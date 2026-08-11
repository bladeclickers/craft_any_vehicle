extends Node2D

@onready var vid: VideoStreamPlayer = $MeshInstance2D/VideoStreamPlayer

func _on_video_stream_player_finished() -> void:
	Transition.change_scene("res://scenes/editor.tscn")
