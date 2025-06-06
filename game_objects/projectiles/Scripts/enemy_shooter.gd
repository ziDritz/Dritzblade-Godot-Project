class_name EnemyShooter extends Node2D

signal projectile_shot(projectile: Projectile)

const PROJECTILE_SCENE = preload("res://game_objects/projectiles/Scene/Projectile.tscn")

@export var projectile_resource : ProjectileResource

var owner_type: String = "Enemy"
var muzzle: Vector2 = Vector2(0, -16)


func shoot():
	var projectile: Projectile = PROJECTILE_SCENE.instantiate()
	projectile.init(
		projectile_resource,
		global_position - muzzle,
		180.0,
		Vector2.DOWN,
		owner_type
	)
	
	projectile_shot.emit(projectile)
