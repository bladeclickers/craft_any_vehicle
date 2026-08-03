extends Area3D

func _process(_delta: float) -> void:
	for area in get_overlapping_areas():
		if area.name == "brick_box":
			Globals.bricks.erase(area.position)
			area.get_parent().free()
