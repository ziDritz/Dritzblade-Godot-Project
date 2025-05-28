extends Node2D

signal level_transition_animation_out_finished
signal level_cleared
signal level_paused(level)

@export var boss: Unit

func _ready() -> void:
	$LevelTransition.play("level_transition_in")

		# on boss killed



func _on_path_follow_2d_progess_ratio_ended(end_position: Vector2, unit: Unit) -> void:
	unit.get_node("Movement").position = end_position
	add_child(unit) 


func _on_path_follow_2d_progess_ratio_ended_without_follower() -> void:
	pass # Replace with function body.
