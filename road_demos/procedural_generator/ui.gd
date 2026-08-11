extends Control

var ran = false

@onready var car = $"../RoadManager/vehicles/BaseCar"

@onready var speedometer = $speedometer
@onready var engine_identifier = $engine_idenfifier
@onready var brake_identifier = $brake_idenfifier
@onready var mass_identifier = $mass_idenfifier

func _process(_delta: float) -> void:
	var speed = car.linear_velocity.dot(car.global_transform.basis.z)
	var speed_km_h = speed * 3.6
	speedometer.text = "Speed: " + str(round(speed_km_h*10)/10) + " km/h"
	engine_identifier.text = "Engine: " + Globals.engine_type
	brake_identifier.text = "Brake Power: " + str(Globals.brake_force)
	mass_identifier.text = "Mass: " + str(car.mass) + "kg"
	
	if Input.is_action_just_pressed("reset"):
		Transition.change_scene("res://scenes/editor.tscn")
