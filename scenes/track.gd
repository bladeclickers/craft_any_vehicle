extends Node3D

@onready var car = $BaseCar
@onready var engine = $BaseCar/engine

@onready var speedometer = $speedometer
@onready var engine_identifier = $engine_idenfifier
@onready var mass_identifier = $mass_idenfifier

func _process(delta: float) -> void:
	var speed = car.linear_velocity.dot(car.global_transform.basis.z)
	speedometer.text = "Speed: " + str(round(speed*10)/10)
	engine_identifier.text = "Engine: " + engine.engine_type
	mass_identifier.text = "Mass: " + str(car.mass) + "kg"
