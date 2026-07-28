extends VehicleBody3D

const BASE_MASS = 500
const MAX_STEERANGLE = 0.15
const THIRD_PERSON = Vector3(0, 0.733, -2.667)
const FIRST_PERSON = Vector3(0, 0.441, 0.106)
const BASE_CENTER_MASS = Vector3(0, 0, 0)
const MEDIUM_CENTER_MASS = Vector3(0, 0, -0.25)
const BIG_CENTER_MASS = Vector3(0, 0, -0.5)

const BRICK_SCENE = preload("res://assets/brick.tscn")

var editor_mode = false
var loaded = false

@onready var stream = $AudioStreamPlayer3D
@onready var fr = $"VehicleWheel3D"
@onready var rr = $"VehicleWheel3D2"
@onready var fl = $"VehicleWheel3D3"
@onready var rl = $"VehicleWheel3D4"
@onready var cam = $Camera3D
@onready var engine = $engine

@onready var wheels = [fr, fl, rr, rl]
@onready var f_wheels = [fr, fl]
@onready var r_wheels = [rr, rl]

func _ready() -> void:
	engine.change_color(Color(0,0,0))
	fr.change_color(Color(0,0,0))
	mass = BASE_MASS + Globals.mass
	for brick_pos in Globals.bricks:
		var brick = BRICK_SCENE.instantiate()
		brick.position = brick_pos
		add_child(brick)
	loaded = true

func _physics_process(delta):
	if editor_mode:
		for wheel in wheels:
			wheel.find_child("StaticBody3D").find_child("CollisionShape3D").disabled = false
		return
	
	for wheel in wheels:
		wheel.find_child("StaticBody3D").find_child("CollisionShape3D").disabled = true
		
	if Globals.engine_type == "Base Engine":
		center_of_mass.z = BASE_CENTER_MASS.z
	elif Globals.engine_type == "Medium Engine":
		center_of_mass.z = MEDIUM_CENTER_MASS.z if Globals.rear_engine else -MEDIUM_CENTER_MASS.z
	elif Globals.engine_type == "Big Engine":
		center_of_mass.z = BIG_CENTER_MASS.z if Globals.rear_engine else -BIG_CENTER_MASS.z
	
	var speed = linear_velocity.dot(global_transform.basis.z)
	cam.fov = clamp(80 + speed/1.5, 80, 120)
	
	var pitch = abs(speed/14)
	stream.pitch_scale = pitch if pitch > 0 else 0.1
	
	if speed != 0 and (Input.is_action_pressed("w") or Input.is_action_pressed("s")):
		if not stream.playing or stream.get_playback_position() > 1.9:
			stream.play(0.1)
	else:
		stream.stop()
	
	if Input.is_action_just_pressed("camera"):
		if cam.position == THIRD_PERSON:
			cam.position = FIRST_PERSON
		else:
			cam.position = THIRD_PERSON
	
	var target_steer = 0.0
	if Input.is_action_pressed("a"):
		target_steer = MAX_STEERANGLE
	elif Input.is_action_pressed("d"):
		target_steer = -MAX_STEERANGLE

	for wheel in f_wheels:
		wheel.steering = move_toward(wheel.steering, target_steer, (0.5 * delta) if target_steer != 0.0 else delta)

	if Input.is_action_pressed("w"):
		for wheel in wheels:
			wheel.engine_force = Globals.engine_force
	elif Input.is_action_pressed("s"):
		if speed > 0.3:
			for wheel in wheels:
				wheel.engine_force = 0
				wheel.brake = Globals.brake_force
		else:
			for wheel in wheels:
				wheel.engine_force = -Globals.engine_force/2
	else:
		for wheel in wheels:
			wheel.engine_force = 0
