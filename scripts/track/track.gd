extends Node3D

var ran = false

@onready var car = $BaseCar
@onready var engine = $BaseCar/engine

@onready var speedometer = $speedometer
@onready var engine_identifier = $engine_idenfifier
@onready var brake_identifier = $brake_idenfifier
@onready var mass_identifier = $mass_idenfifier

func _process(_delta: float) -> void:
	var speed = car.linear_velocity.dot(car.global_transform.basis.z)
	speedometer.text = "Speed: " + str(round(speed*10)/10)
	engine_identifier.text = "Engine: " + Globals.engine_type
	brake_identifier.text = "Brake Power: " + str(Globals.brake_force)
	mass_identifier.text = "Mass: " + str(car.mass) + "kg"
	
	if car.loaded and not ran:
		for child in car.get_children():
			if child.name.contains("brick"):
				child.find_child("CollisionShape3D").disabled = false
		ran = true
	
	if Input.is_action_just_pressed("reset"):
		get_tree().change_scene_to_file("res://scenes/editor.tscn")
