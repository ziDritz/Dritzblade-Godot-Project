class_name Unit extends Node2D


func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
