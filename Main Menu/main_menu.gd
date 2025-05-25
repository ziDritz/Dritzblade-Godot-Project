extends Control

signal game_start

func _on_button_start_pressed() -> void:
	$LevelTransition.play("level_transition_out")
	$Player.is_controlable = false

func _on_button_exit_pressed() -> void:
	get_tree().quit()


func _on_level_transition_animation_finished(_anim_name: StringName) -> void:
	game_start.emit()
	queue_free()
