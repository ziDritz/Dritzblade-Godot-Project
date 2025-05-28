class_name Wave extends Node2D

const ENEMY_SCENE: PackedScene = preload("res://Unit Manager/Scenes/Enemy.tscn")

var enemy_spawned_count: int = 0
@export var wave_size: int
var is_all_enemy_spawned: bool
var enemy_array: Array[Enemy]
@onready var timer: Timer

signal enemy_spawned(unit: Unit)
signal wave_destroyed(wave: Wave)

func _ready() -> void:
	timer = find_child("Timer")

func _process(_delta):
	if Input.is_key_pressed(KEY_A):
		for enemy in enemy_array:
			enemy.get_node("Health").die()
		

	
func _on_timer_timeout() -> void:
	var unit = ENEMY_SCENE.instantiate()
	enemy_array.append(unit)
	
	unit.find_child("Health").died.connect(_on_unit_died)
	unit.find_child("AnimatedSprite2D").animation_finished.connect(_on_died_unit_animation_end)

	$Path2D.path_follow_2D_init(unit)
	enemy_spawned.emit(unit)

	enemy_spawned_count += 1
	if enemy_spawned_count >= wave_size:
		timer.stop()
		is_all_enemy_spawned = true

func _on_timer_level_timeout() -> void:
	timer.start()


func _on_unit_died(unit):
	enemy_array.erase(unit)


func _on_died_unit_animation_end():
	if enemy_array.size() == 0 && is_all_enemy_spawned:
		wave_destroyed.emit(self)
		queue_free()
