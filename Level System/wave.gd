class_name Wave extends Node2D

const ENEMY_SCENE: PackedScene = preload("res://Unit Manager/Scenes/Enemy.tscn")

var enemy_spawned_count: int = 0
var enemy_died: int = 0
var wave_size: int = 10
@onready var timer: Timer

signal enemy_spawned(unit: Unit)
signal wave_destroyed(wave: Wave)

func _ready() -> void:
	timer = find_child("Timer")
	
func _on_timer_timeout() -> void:
	var unit = ENEMY_SCENE.instantiate()
	unit.find_child("Health").died.connect(_on_unit_died)

	$Path2D.path_follow_2D_init(unit)
	enemy_spawned.emit(unit)

	enemy_spawned_count += 1
	if enemy_spawned_count >= wave_size:
		timer.stop()

func _on_timer_level_timeout() -> void:
	timer.start()

func _on_unit_died():
	enemy_died += 1
	if enemy_died >= wave_size:
		wave_destroyed.emit(self)
		print(str(self) + " destroyed")
		queue_free()
