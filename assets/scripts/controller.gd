extends Node2D

const CURSOR_SPEED = 800.0
var virtual_mouse_pos := Vector2.ZERO 

var active_slider: Range = null
var open_option_button: OptionButton = null 

func _ready() -> void:
	virtual_mouse_pos = get_viewport().get_mouse_position()

func _process(delta: float) -> void:
	var stick := Input.get_vector("jp_a", "jp_d", "jp_w", "jp_s")
	
	if stick.length() > 0.0:
		virtual_mouse_pos += stick * CURSOR_SPEED * delta
		get_viewport().warp_mouse(virtual_mouse_pos)
	else:
		virtual_mouse_pos = get_viewport().get_mouse_position()
		
	if active_slider and stick.length() > 0.0:
		active_slider.value += stick.x * (active_slider.max_value - active_slider.min_value) * 0.5 * delta

	if Input.is_action_just_pressed("jp_select"):
		active_slider = get_slider_at_position(get_tree().root, virtual_mouse_pos)
		if not active_slider:
			var popup = open_option_button.get_popup() if open_option_button else null
			if popup and popup.visible:
				handle_popup_click(open_option_button, popup, virtual_mouse_pos)
			else:
				press_ui_at_position(get_tree().root, virtual_mouse_pos)

	elif Input.is_action_just_released("jp_select"):
		if active_slider:
			active_slider = null
		else:
			var popup = open_option_button.get_popup() if open_option_button else null
			if not (popup and popup.visible):
				release_ui_at_position(get_tree().root, virtual_mouse_pos)

func press_ui_at_position(node: Node, click_pos: Vector2) -> bool:
	if node is BaseButton and node.is_visible_in_tree() and not node.disabled:
		if node.get_global_rect().has_point(click_pos):
			node.emit_signal("button_down")
			if node is CheckButton or node is CheckBox:
				if "button_pressed" in node:
					node.button_pressed = !node.button_pressed
			node.emit_signal("pressed")
			
			if node is OptionButton:
				node.show_popup()
				open_option_button = node
				
			return true

	for child in node.get_children():
		if press_ui_at_position(child, click_pos):
			return true
	return false

func release_ui_at_position(node: Node, click_pos: Vector2) -> bool:
	if node is BaseButton and node.is_visible_in_tree() and not node.disabled:
		if node.get_global_rect().has_point(click_pos):
			node.emit_signal("button_up")
			return true

	for child in node.get_children():
		if release_ui_at_position(child, click_pos):
			return true
	return false

func handle_popup_click(opt_btn: OptionButton, popup: PopupMenu, click_pos: Vector2):
	var popup_rect := Rect2(popup.position, popup.size)

	if !popup_rect.has_point(click_pos):
		popup.hide()
		open_option_button = null
		return

	var item_height = 29.0
	var local_y = click_pos.y - popup.position.y
	var index = int(local_y / item_height)

	if index >= 0 and index < popup.item_count:
		opt_btn.select(index)
		opt_btn.item_selected.emit(index)

	popup.hide()
	open_option_button = null

func get_slider_at_position(node: Node, click_pos: Vector2) -> Range:
	if node is Range and node.is_visible_in_tree() and not node.editable == false:
		if node.get_global_rect().has_point(click_pos):
			return node

	for child in node.get_children():
		var found = get_slider_at_position(child, click_pos)
		if found:
			return found
			
	return null
