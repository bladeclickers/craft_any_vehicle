extends Area3D

func _process(delta: float) -> void:
	for area in get_overlapping_areas():
		if area.name == "brick_box":
			area.get_parent().free()
