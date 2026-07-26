extends VehicleBody3D

const BASE_MASS = 500
const MAX_STEERANGLE = 0.15

var editor_mode = false

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
	mass = BASE_MASS + Globals.mass

func _physics_process(delta):
	if editor_mode:
		return
	
	var speed = linear_velocity.dot(global_transform.basis.z)
	cam.fov = clamp(lerp(cam.fov, 160 * (speed/40), 2), 80, 120)
	
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
		if speed > 0:
			for wheel in wheels:
				wheel.engine_force = 0
				wheel.brake = Globals.brake_force
		else:
			for wheel in wheels:
				wheel.engine_force = -Globals.engine_force/2
	else:
		for wheel in wheels:
			wheel.engine_force = 0
