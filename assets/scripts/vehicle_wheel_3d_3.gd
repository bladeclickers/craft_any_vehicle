extends VehicleWheel3D

@onready var mesh = $MeshInstance3D3

var hovering_wheel = false

func change_color(color: Color):
	mesh.mesh.material.albedo_color = color

func _on_static_body_3d_mouse_entered() -> void:
	hovering_wheel = true

func _on_static_body_3d_mouse_exited() -> void:
	hovering_wheel = false
