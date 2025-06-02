extends Node2D

signal level_transition_animation_out_finished

func _ready() -> void:
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = 3
	timer.one_shot = true
	timer.timeout.connect($AnimationPlayer.play.bind("level_transition_out"))
	timer.start()
	

func _on_level_transition_animation_finished(anim_name: StringName) -> void:
	if anim_name == "level_transition_out":
		level_transition_animation_out_finished.emit()
		queue_free()
