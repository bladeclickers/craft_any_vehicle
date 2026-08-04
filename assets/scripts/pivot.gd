extends Node3D

@onready var cam = $Camera3D

var joypad_sens := 3.0
var sensitivity := 0.005
var rotating := false

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			rotating = event.pressed
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED if rotating else Input.MOUSE_MODE_VISIBLE

	if event is InputEventMouseMotion:
		if rotating:
			rotate_y(-event.relative.x * sensitivity)
			rotation.x -= event.relative.y * sensitivity
			rotation.x = clamp(rotation.x, deg_to_rad(-60), deg_to_rad(60))

func _process(delta: float) -> void:
	var stick := Input.get_vector("jp2_a", "jp2_d", "jp2_w", "jp2_s")
	
	if stick.length() > 0.0:
		rotation.y -= stick.x * joypad_sens * delta
		rotation.x -= stick.y * joypad_sens * delta

		rotation.x = clamp(rotation.x, deg_to_rad(-60), deg_to_rad(60))
