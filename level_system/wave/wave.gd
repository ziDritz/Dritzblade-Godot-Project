class_name Wave extends Node2D

const ENEMY_SCENE: PackedScene = preload("res://units/Scenes/Enemy.tscn")

var enemy_spawned_count: int = 0
@export var wave_size: int
var is_all_enemy_spawned: bool
var enemy_array: Array[Enemy]
@onready var timer: Timer

signal enemy_spawned(character_body_2D: CharacterBody2D)
signal wave_destroyed(wave: Wave)

func _ready() -> void:
	timer = find_child("Timer")

func _process(_delta):
	if Input.is_key_pressed(KEY_A):
		for enemy in enemy_array:
			enemy.get_node("Health").die()
		

	
func _on_timer_timeout() -> void:
	var character_body_2D = ENEMY_SCENE.instantiate()
	enemy_array.append(character_body_2D)
	
	character_body_2D.find_child("Health").died.connect(_on_character_body_2D_died)
	character_body_2D.find_child("AnimatedSprite2D").animation_finished.connect(_on_died_character_body_2D_animation_end)

	$Path2D.path_follow_2D_init(character_body_2D)
	enemy_spawned.emit(character_body_2D)

	enemy_spawned_count += 1
	if enemy_spawned_count >= wave_size:
		timer.stop()
		is_all_enemy_spawned = true

func _on_timer_level_timeout() -> void:
	timer.start()


func _on_character_body_2D_died(character_body_2D):
	enemy_array.erase(character_body_2D)


func _on_died_character_body_2D_animation_end():
	if enemy_array.size() == 0 && is_all_enemy_spawned:
		wave_destroyed.emit(self)
		queue_free()
