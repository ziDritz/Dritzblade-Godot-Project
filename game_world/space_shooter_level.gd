class_name SpaceShooterLevel
extends Node2D


signal level_cleared(current_game_level: Game.GameLevel)
signal game_over

const PLAYER_SCENE = preload("res://game_objects/units/scenes/Player.tscn")

var wave_count: int
var current_game_level: Game.GameLevel
var boss: CharacterBody2D

@onready var timer_level: Timer = $TimerLevel
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var player: Player = $Player
@onready var player_animation_player: AnimationPlayer = $PlayerAnimationPlayer


func init(_packed_scene: PackedScene, _level_type: String, _current_game_level: Game.GameLevel):
	
	# Reset
	if player == null:
		player = PLAYER_SCENE.instantiate()
		player.init()
		player.died.connect(_on_player_died)
		player.shot.connect(_on_shooter_projectile_shot)
		add_child(player)
		
	if boss != null:
		boss.queue_free()
		
	wave_count = 0
	current_game_level = _current_game_level
	
	for child in get_children():
		if child is Wave : child.queue_free()
		if child is Projectile : child.queue_free()
	
	# Instanciation
	if _level_type == "Waves":
		var waves = _packed_scene.instantiate()
		add_child(waves)
		
		for wave: Wave in waves.get_children():
			wave_count += 1
			wave.wave_destroyed.connect(_on_wave_destroyed)
			wave.enemy_spawned.connect(audio_stream_player._on_wave_enemy_spawned)
			wave.enemy_spawned.connect(_on_wave_enemy_spawned)
			timer_level.timeout.connect(wave._on_timer_level_timeout)
			wave.reparent(self)
			
		waves.queue_free()
	
	if _level_type == "Boss":
		var boss_path_2D = _packed_scene.instantiate()
		boss = boss_path_2D.get_child(0).get_child(0)
		boss.died.connect(_on_boss_died)
		boss.shot.connect(_on_shooter_projectile_shot)
		add_child(boss_path_2D)
	

	timer_level.start()


func animate_player_in():
	player_animation_player.play("player_transitions/player_transition_in")


func animate_player_out():
	player_animation_player.play("player_transitions/player_transition_out")


func _on_boss_died():
	level_cleared.emit(current_game_level)


func _on_wave_destroyed(_wave) -> void:
	wave_count -= 1
	if wave_count == 0:
		level_cleared.emit(current_game_level)
		

func _on_wave_enemy_spawned(_character_body_2D: CharacterBody2D):
	_character_body_2D.shooter.projectile_shot.connect(_on_shooter_projectile_shot)


func _on_shooter_projectile_shot(projectile: Projectile):
	add_child(projectile)
	
	if projectile.shooter_owner is Player: 
		projectile.direction = Vector2.UP
		
	if projectile.shooter_owner is Enemy: 
		projectile.direction = Vector2.DOWN
		projectile.rotation = 180.0


func _on_boss_shot(projectile: Projectile):
	add_child(projectile)

func _on_player_died() -> void:
	game_over.emit()
