class_name SpaceShooterLevel
extends Node2D


signal level_cleared

var wave_count: int

@onready var timer_level: Timer = $TimerLevel
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var level_transition: AnimationPlayer = $LevelTransition
@onready var player: Player = $Player


func _ready() -> void:
	_init()


func _init():
	for child in get_children():
		if child is Wave:
			var wave = child
			wave_count += 1
			wave.wave_destroyed.connect(_on_wave_destroyed)
			wave.enemy_spawned.connect(audio_stream_player._on_wave_enemy_spawned)
			wave.enemy_spawned.connect(_on_wave_enemy_spawned)
			timer_level.timeout.connect(wave._on_timer_level_timeout)
	
			
func _on_wave_destroyed(_wave) -> void:
	wave_count -= 1
	if wave_count == 0:
		level_cleared.emit()
		await get_tree().create_timer(3.0).timeout
		player.is_controlable = false
		level_transition.play("level_transition_out")


func _on_wave_enemy_spawned(_character_body_2D: CharacterBody2D):
	_character_body_2D.shooter.projectile_shot.connect(_on_shooter_projectile_shot)


func _on_shooter_projectile_shot(projectile: Projectile):
	add_child(projectile)
	
	if projectile.shooter_owner is Player: 
		projectile.direction = Vector2.UP
		
	if projectile.shooter_owner is Enemy: 
		projectile.direction = Vector2.DOWN
		projectile.rotation = 180.0
