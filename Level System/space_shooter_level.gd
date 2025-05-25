extends Node2D

var wave_count: int

signal level_cleared

func _ready() -> void:
	for child in get_children():
		if child is Wave:
			wave_count += 1
			child.wave_destroyed.connect(_on_wave_destroyed)
			child.enemy_spawned.connect($AudioStreamPlayer._on_wave_enemy_spawned)
			$TimerLevel.timeout.connect(child._on_timer_level_timeout)

	$LevelTransition.play("level_transition_in")
			
func _on_wave_destroyed(_wave) -> void:
	wave_count -= 1
	if wave_count == 0:
		await get_tree().create_timer(3.0).timeout
		$Player.is_controlable = false
		$LevelTransition.play("level_transition_out")


func _on_level_transition_animation_finished(anim_name: StringName) -> void:
	if anim_name == "level_transition_out":
		level_cleared.emit()
		queue_free()
