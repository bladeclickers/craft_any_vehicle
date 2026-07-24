extends StaticBody3D

@onready var mesh = $MeshInstance3D
var mouse_hovering = false

func change_color(color: Color):
	mesh.mesh.material.albedo_color = color

func _on_mouse_entered() -> void:
	mouse_hovering = true
	
func _on_mouse_exited() -> void:
	mouse_hovering = false
