class_name Boss extends CharacterBody2D

const MOVE_1_CURVE = preload("res://level_system/boss/boss_curves/move 1.tres")
const MOVE_2_CURVE = preload("res://level_system/boss/boss_curves/move 2.tres")

@export var path_2D: Path2D
@export var path_follow_2D: PathFollow2D


@export var speed_move_entrance: int
@export var speed_move_1: int
@export var speed_move_2: int

@onready var health: Health = $Health
@onready var collision_polygon_2d: CollisionPolygon2D = $CollisionPolygon2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var boss_shooter: BossShooter = $BossShooter
@onready var decision_timer: Timer = $DecisionTimer


func _ready() -> void:
	path_follow_2D.progess_path(speed_move_entrance)

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_Z:
			move_1()
		if event.pressed and event.keycode == KEY_E:
			move_2()
		if event.pressed and event.keycode == KEY_R:
			boss_shooter.shoot()

func move_1():
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = 1.0
	timer.one_shot = false
	timer.timeout.connect(boss_shooter.shoot)
	timer.start()
	
	path_2D.curve = MOVE_1_CURVE
	path_follow_2D.progess_path(speed_move_1)
	path_follow_2D.connect(
		"progess_ratio_ended", 
		func():	
			if timer != null:
				timer.stop()
				timer.queue_free()	
	)



func move_2():
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = 1.0
	timer.one_shot = false
	timer.timeout.connect(boss_shooter.shoot)
	timer.start()
	
	path_2D.curve = MOVE_2_CURVE
	path_follow_2D.progess_path(speed_move_2)
	path_follow_2D.connect(
		"progess_ratio_ended", 
		func():	
			if timer != null:
				timer.stop()
				timer.queue_free()	
	)


func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()


func _on_health_died(character_body_2D: CharacterBody2D) -> void:
	collision_polygon_2d.queue_free()
	decision_timer.queue_free()
	boss_shooter.queue_free()
