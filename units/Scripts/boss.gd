class_name Boss extends CharacterBody2D

const MOVE_1_CURVE = preload("res://level_system/boss/boss_curves/move 1.tres")
const MOVE_2_CURVE = preload("res://level_system/boss/boss_curves/move 2.tres")

@export var path_2D: Path2D
@export var path_follow_2D: PathFollow2D


@export var speed_move_entrance: int
@export var speed_move_1: int
@export var speed_move_2: int

@onready var health: Health = $Health
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var shooter: Shooter = $Shooter
@onready var decision_timer: Timer = $DecisionTimer


func _ready() -> void:
	path_follow_2D.progess_path(speed_move_entrance)

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_Z:
			move_1()
		if event.pressed and event.keycode == KEY_E:
			move_2()

func move_1():
	path_2D.curve = MOVE_1_CURVE
	path_follow_2D.progess_path(speed_move_1)

	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = 1.0
	timer.one_shot = false
	timer.timeout.connect(shooter.shoot)
	timer.start()

func move_2():
	path_2D.curve = MOVE_2_CURVE
	path_follow_2D.progess_path(speed_move_2)
