extends Panel

var prev_id = 0

@onready var hp_slider = $hp_slider
@onready var weight_slider = $weight_slider
@onready var hp_label = $hp_label
@onready var weight_label = $weight_label
@onready var engine_select = $engine_select
@onready var position_toggle = $position_toggle

func set_engine(hp: float, weight: float, engine: String):
	hp_slider.value = hp
	weight_slider.value = weight
	hp_label.text = str(int(hp))
	weight_label.text = str(int(weight))
	Globals.engine_type = engine
	Globals.engine_force = hp
	Globals.mass = weight

func _ready() -> void:
	engine_select.selected = Globals.engine_types.find(Globals.engine_type)

func _process(_delta: float) -> void:
	Globals.rear_engine = position_toggle.button_pressed
	var id = engine_select.get_selected_id()
	if id != prev_id:
		if id == 0:
			set_engine(400.0, 100.0, "Base Engine")
		elif id == 1:
			set_engine(700.0, 200.0, "Medium Engine")
		elif id == 2:
			set_engine(1200.0, 400.0, "Big Engine")
		prev_id = id
