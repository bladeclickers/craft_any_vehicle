extends Label

func _ready() -> void:
	position.x = (get_window().size.x / 2.0) - size.x / 2.0
