extends Button

func _ready() -> void:
	position.x = (get_window().size.x / 2.0) - size.x / 2.0

func _on_pressed() -> void:
	Transition.change_scene("res://scenes/editor.tscn")
