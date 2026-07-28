extends Node3D

const BRICK_SCENE = preload("res://assets/brick.tscn")

@onready var car = $BaseCar
@onready var engine = $BaseCar/engine
@onready var fr = $"BaseCar/VehicleWheel3D"
@onready var rr = $"BaseCar/VehicleWheel3D2"
@onready var fl = $"BaseCar/VehicleWheel3D3"
@onready var rl = $"BaseCar/VehicleWheel3D4"
@onready var wheels = [fr, fl, rr, rl]

@onready var car_cam = $BaseCar/pivot/Camera3D
@onready var editor_cam = $pivot/Camera3D
@onready var engine_pane = $engine_pane
@onready var wheel_pane = $wheel_pane

const BRICK_SIZE = Vector3(0.3, 0.3, 0.3)

func _ready() -> void:
	car.editor_mode = true
	car_cam.current = false
	editor_cam.current = true

func _process(_delta: float) -> void:
	if engine.mouse_hovering:
		if Input.is_action_just_pressed("select") and not wheel_pane.visible:
			engine_pane.visible = !engine_pane.visible
			engine.change_color(Color(0, 255, 0) if engine_pane.visible else Color(0, 0, 0))
			
		if !engine_pane.visible:
			engine.change_color(Color(0, 0.5, 0))
	else:
		engine.change_color(Color(0, 255, 0) if engine_pane.visible else Color(0, 0, 0))
	
	var hovering_wheel = false
	
	if fr.hovering_wheel:
		hovering_wheel = true
		if not wheel_pane.visible:
			fr.change_color(Color(0, 0.5, 0))
	
	if hovering_wheel and Input.is_action_just_pressed("select") and not engine_pane.visible:
		wheel_pane.visible = !wheel_pane.visible
		# same mesh used for all wheels, no use repeating
		fr.change_color(Color(0, 255, 0) if wheel_pane.visible else Color(0, 0, 0))
	if not hovering_wheel and not wheel_pane.visible:
		fr.change_color(Color(0, 0, 0)) # same as above ^

	if Input.is_action_just_pressed("select") and not engine.mouse_hovering and not hovering_wheel and not engine_pane.visible and not wheel_pane.visible:
		for child in car.get_children():
			if child.name.contains("brick"):
				child.find_child("CollisionShape3D").disabled = false
		var mouse_pos = get_viewport().get_mouse_position()
		var ray_origin = editor_cam.project_ray_origin(mouse_pos)
		var ray_end = ray_origin + editor_cam.project_ray_normal(mouse_pos) * 100.0
		var space_state = get_world_3d().direct_space_state
		var query = PhysicsRayQueryParameters3D.create(ray_origin, ray_end, 1)
		var result = space_state.intersect_ray(query)
		for child in car.get_children():
			if child.name.contains("brick"):
				child.find_child("CollisionShape3D").disabled = true
		
		if result and (result.collider == car or result.collider.name.contains("brick")):
			var hit_global = result.position + result.normal * 0.15
			if hit_global.y - 0.15 < car.get_node("floor").global_position.y:
				return
				
			var brick = BRICK_SCENE.instantiate()
			brick.position = car.to_local(hit_global)
			brick.name = "brick" + str(Globals.bricks.size())
			car.add_child(brick)
			Globals.bricks.append(brick.position)

	if Input.is_action_just_pressed("clear"):
		for child in car.get_children():
			if child.name.contains("brick"):
				child.queue_free()
		Globals.bricks.clear()

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/track.tscn")
