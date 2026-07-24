extends Panel

var prev_id = 0

@onready var hp_slider = $hp_slider
@onready var weight_slider = $weight_slider
@onready var hp_label = $hp_label
@onready var weight_label = $weight_label
@onready var engine_select = $engine_select

func _process(delta: float) -> void:
	var id = engine_select.get_selected_id()
	if id != prev_id:
		if id == 0:
			hp_slider.value = 350
			weight_slider.value = 100
			hp_label.text = "350"
			weight_label.text = "100"
			Globals.engine_type = "Base Engine"
			Globals.engine_force = 350.0
			Globals.mass = 100.0
		elif id == 1:
			hp_slider.value = 700
			weight_slider.value = 200
			hp_label.text = "700"
			weight_label.text = "200"
			Globals.engine_type = "Medium Engine"
			Globals.engine_force = 700.0
			Globals.mass = 200.0
		elif id == 2:
			hp_slider.value = 1000
			weight_slider.value = 400
			hp_label.text = "1000"
			weight_label.text = "400"
			Globals.engine_type = "Big Engine"
			Globals.engine_force = 1000.0
			Globals.mass = 400.0
		prev_id = id
