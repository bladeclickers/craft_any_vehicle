extends Node3D

@onready var car = $BaseCar
@onready var engine = $BaseCar/engine
@onready var car_cam = $BaseCar/Camera3D
@onready var editor_cam = $pivot/Camera3D
@onready var engine_pane = $engine_pane

func _ready() -> void:
	car.editor_mode = true
	car_cam.current = false
	editor_cam.current = true

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("select") and engine.mouse_hovering:
		engine_pane.visible = !engine_pane.visible
		engine.change_color(Color(0, 255, 0) if engine_pane.visible else Color(0, 0, 0))

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/track.tscn")
