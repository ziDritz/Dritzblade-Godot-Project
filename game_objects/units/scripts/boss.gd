class_name Boss
extends CharacterBody2D


signal died
signal shot(projectile: Projectile)

const MOVE_1_CURVE = preload("res://game_objects/boss/boss_curves/move 1.tres")
const MOVE_2_CURVE = preload("res://game_objects/boss/boss_curves/move 2.tres")

@export var path_2D: Path2D
@export var path_follow_2D: PathFollow2D

@export var speed_move_entrance: int
@export var speed_move_1: int
@export var speed_move_2: int

@onready var health: Health = $Health
@onready var collision_polygon_2d: CollisionPolygon2D = $CollisionPolygon2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var boss_shooter: BossShooter = $BossShooter
@onready var decision_timer: Timer = $DecisionTimer


func _ready() -> void:
	path_follow_2D.progess_path(speed_move_entrance)




func _move_1():
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



func _move_2():
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
	died.emit()
	queue_free()


func _on_health_died(_character_body_2D: CharacterBody2D) -> void:
	collision_polygon_2d.queue_free()
	decision_timer.queue_free()
	boss_shooter.queue_free()


func _on_decision_timer_timeout() -> void:
	var chance = randf()
	if chance <= 0.5:
		_move_1()
	else:
		_move_2()


func _on_path_follow_2d_progess_ratio_ended() -> void:
	var decision_time = randf_range(1.0, 5.0)
	if decision_time == null:
		return
	decision_timer.wait_time = decision_time
	decision_timer.start()


func _on_boss_shooter_projectile_shot(projectile: Projectile) -> void:
	shot.emit(projectile)
