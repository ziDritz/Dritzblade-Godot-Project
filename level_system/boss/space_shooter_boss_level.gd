extends Node2D

signal level_transition_animation_out_finished
signal level_cleared
signal level_paused(level)

@export var boss: CharacterBody2D

func _ready() -> void:
	$LevelTransition.play("level_transition_in")

		# on boss killed



func _on_path_follow_2d_progess_ratio_ended(end_position: Vector2, character_body_2D: CharacterBody2D) -> void:
	character_body_2D.get_node("Movement").position = end_position
	add_child(character_body_2D) 


func _on_path_follow_2d_progess_ratio_ended_without_follower() -> void:
	pass # Replace with function body.


func _on_shooter_projectile_shot(projectile: Projectile) -> void:
	add_child(projectile)


func _on_boss_shooter_projectile_shot(projectile: Projectile) -> void:
	add_child(projectile)
