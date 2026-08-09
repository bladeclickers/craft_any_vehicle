extends Control

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		Globals.paused = not Globals.paused
		visible = not visible
	Globals.paused = visible

func _on_button_pressed() -> void:
	visible = false
	Globals.paused = false
