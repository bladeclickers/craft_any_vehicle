extends Node2D

const CURSOR_SPEED = 800.0
var virtual_mouse_pos := Vector2i(0, 0)

func simulate_left_click(click_position: Vector2):
	var press_event = InputEventMouseButton.new()
	press_event.button_index = MOUSE_BUTTON_LEFT
	press_event.pressed = true
	press_event.position = click_position
	
	Input.parse_input_event(press_event)

	var release_event = InputEventMouseButton.new()
	release_event.button_index = MOUSE_BUTTON_LEFT
	release_event.pressed = false
	release_event.position = click_position
	
	Input.parse_input_event(release_event)

func _ready() -> void:
	virtual_mouse_pos = DisplayServer.mouse_get_position()

func _process(delta: float) -> void:
	var stick := Input.get_vector("jp_a", "jp_d", "jp_w", "jp_s")
	
	if stick.length() > 0.0:
		virtual_mouse_pos += Vector2i(stick * CURSOR_SPEED * delta)
		get_viewport().warp_mouse(virtual_mouse_pos)
	else:
		virtual_mouse_pos = get_viewport().get_mouse_position()
		
	if Input.is_action_just_pressed("jp_select"):
		simulate_left_click(get_viewport().get_mouse_position())
