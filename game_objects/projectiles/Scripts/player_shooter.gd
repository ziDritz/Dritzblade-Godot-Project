class_name PlayerShooter extends Node2D

signal projectile_shot(projectile: Projectile)
signal projectile_in_charger_changed(projectile_in_charger: int)

const PROJECTILE_SCENE = preload("res://game_objects/projectiles/Scene/Projectile.tscn")

@export var projectile_resource : ProjectileResource
@export var fire_rate : float
@export var projectile_in_charger: int : set = set_projectile_in_charger
@export var charger_capacity: int
@export var reload_time: float

var is_projectile_ready: bool = true
var is_reloading: bool = false
var owner_type: String = "Player"
var muzzle: Vector2 = Vector2(0, -26)


func _ready() -> void:
	projectile_in_charger = charger_capacity


func shoot():
	if is_projectile_ready && projectile_in_charger > 0:
		var projectile: Projectile = PROJECTILE_SCENE.instantiate()
		projectile.init(
			projectile_resource,
			global_position + muzzle,
			0.0,
			Vector2.UP,
			owner_type
			)
		
		projectile_in_charger -= 1
		is_projectile_ready = false
		projectile_shot.emit(projectile)
				
		if is_reloading == false:
			_reload()
		
		await get_tree().create_timer(fire_rate).timeout
		is_projectile_ready = true		


func _reload():
	is_reloading = true
	while projectile_in_charger < charger_capacity:
		await get_tree().create_timer(reload_time).timeout
		projectile_in_charger += 1
	is_reloading = false


func set_projectile_in_charger(value):
	projectile_in_charger = value
	projectile_in_charger_changed.emit(value)
