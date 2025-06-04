class_name SceneTransitionPlayer
extends CanvasLayer

signal animation_finished

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func transition_fade_out() -> void:
	animation_player.play('fade_out')
	
	
func transition_fade_in() -> void:
	animation_player.play('fade_in')
	

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	animation_finished.emit()
