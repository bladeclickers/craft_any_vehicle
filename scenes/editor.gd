extends Node3D

@onready var car = $BaseCar
@onready var engine = $BaseCar/engine
@onready var car_cam = $BaseCar/Camera3D
@onready var editor_cam = $pivot/Camera3D
@onready var property_pane = $property_pane

func _ready() -> void:
	car.editor_mode = true
	car_cam.current = false
	editor_cam.current = true

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("select") and engine.mouse_hovering:
		property_pane.visible = !property_pane.visible

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/track.tscn")
