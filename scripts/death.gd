extends Node2D

@onready var vid: VideoStreamPlayer = $MeshInstance2D/VideoStreamPlayer

func _process(delta: float) -> void:
	if vid.stream_position >= 6.0:
		Transition.change_scene("res://scenes/editor.tscn")
