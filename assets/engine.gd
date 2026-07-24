extends StaticBody3D

var engine_type = "Base Engine"
var engine_force = 400.0
var brake_force = 50.0
var mass = 100.0
var mouse_hovering = false

func _on_mouse_entered() -> void:
	mouse_hovering = true
	
func _on_mouse_exited() -> void:
	mouse_hovering = false
