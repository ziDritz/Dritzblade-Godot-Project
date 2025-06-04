class_name GameOver
extends Control

func _on_button_restart_pressed() -> void:
	get_tree().reload_current_scene()
