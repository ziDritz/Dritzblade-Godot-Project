class_name SceneTransitionPlayer
extends CanvasLayer

signal animation_finished

@onready var animation_player: AnimationPlayer = $AnimationPlayer 

func _ready() -> void:
	visible = false 
	# Sinon, le layer est au dessus de tout et impossible 
	# d'intéragir avec les controle nodes d'autres states 
	# (ex, Buttons du Main Menu) 


func play_transition(transition_name: String):
	visible = true
	animation_player.play(transition_name)
	

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	visible = false
	animation_finished.emit()
