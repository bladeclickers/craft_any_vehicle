extends Panel

@onready var brake_slider = $brake_slider
@onready var hp_label = $brake_label

func _process(_delta: float) -> void:
	Globals.brake_force = brake_slider.value
	hp_label.text = str(Globals.brake_force)
