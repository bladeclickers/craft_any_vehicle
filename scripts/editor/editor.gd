extends Node3D

@onready var car = $BaseCar
@onready var engine = $BaseCar/engine
@onready var fr = $"BaseCar/VehicleWheel3D"
@onready var rr = $"BaseCar/VehicleWheel3D2"
@onready var fl = $"BaseCar/VehicleWheel3D3"
@onready var rl = $"BaseCar/VehicleWheel3D4"
@onready var wheels = [fr, fl, rr, rl]

@onready var car_cam = $BaseCar/Camera3D
@onready var editor_cam = $pivot/Camera3D
@onready var engine_pane = $engine_pane
@onready var wheel_pane = $wheel_pane

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
			
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/track.tscn")
