extends Button

func _ready() -> void:
	position.x = (get_window().size.x / 2) - size.x / 2

func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/editor.tscn")
