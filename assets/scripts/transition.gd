extends CanvasLayer

@onready var color_rect = $ColorRect

func _ready():
	color_rect.modulate.a = 0.0

func change_scene(target_scene_path: String) -> void:
	var tween_out = create_tween()
	tween_out.tween_property(color_rect, "modulate:a", 1.0, 0.5)
	await tween_out.finished
	
	get_tree().change_scene_to_file(target_scene_path)
	
	await get_tree().process_frame
	
	var tween_in = create_tween()
	tween_in.tween_property(color_rect, "modulate:a", 0.0, 0.5)
