extends StaticBody3D

const BASE_SCALE = Vector3(0.274, 0.246, 0.594)
const MEDIUM_SCALE = Vector3(0.311, 0.246, 0.709)
const BIG_SCALE = Vector3(0.386, 0.246, 0.811)

@onready var mesh = $MeshInstance3D
var mouse_hovering = false

func change_color(color: Color):
	mesh.mesh.material.albedo_color = color
	
func _process(_delta: float) -> void:
	if Globals.engine_type == "Base Engine":
		scale = BASE_SCALE
	elif Globals.engine_type == "Medium Engine":
		scale = MEDIUM_SCALE
	elif Globals.engine_type == "Big Engine":
		scale = BIG_SCALE

func _on_mouse_entered() -> void:
	mouse_hovering = true
	
func _on_mouse_exited() -> void:
	mouse_hovering = false
