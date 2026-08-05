extends Panel

@onready var mouse_sens = $mouse_sens
@onready var mouse_sens_label = $mouse_sens_label
@onready var l_stick_sens = $l_stick_sens
@onready var l_stick_sens_label = $l_stick_sens_label
@onready var r_stick_sens = $r_stick_sens
@onready var r_stick_sens_label = $r_stick_sens_label

func _process(delta: float) -> void:
	Globals.mouse_sens = mouse_sens.value / 10000
	mouse_sens_label.text = str(int(mouse_sens.value))
	Globals.l_stick_sens = l_stick_sens.value * 10
	l_stick_sens_label.text = str(int(l_stick_sens.value))
	Globals.r_stick_sens = r_stick_sens.value / 10
	r_stick_sens_label.text = str(int(r_stick_sens.value))
