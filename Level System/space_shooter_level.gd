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
			
func _on_wave_destroyed(wave) -> void:
	wave_count -= 1
	if wave_count == 0:
		await get_tree().create_timer(3.0).timeout
		level_cleared.emit()
		queue_free()
		
			
