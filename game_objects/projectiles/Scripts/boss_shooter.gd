class_name BossShooter extends Node2D

signal projectile_shot(projectile: Projectile)

const PROJECTILE_SCENE = preload("res://game_objects/projectiles/Scene/Projectile.tscn")

@export var projectile_resource : ProjectileResource
@export var projectile_count : int 
@export var first_angle_side: float
@export var second_angle_side: float

var owner_type: String = "Boss"
var muzzle: Vector2 = Vector2(0, 106)

func shoot():
	var angle_offset = (second_angle_side - first_angle_side) / (projectile_count - 1)
	for i in projectile_count:
		
		var angle = first_angle_side + (angle_offset * i)
		var projectile_direction = Vector2(
			sin(deg_to_rad(angle)),
			cos(deg_to_rad(angle))
		)
		
		var projectile: Projectile = PROJECTILE_SCENE.instantiate()
		projectile.init(
			projectile_resource,
			global_position - muzzle,
			0.0,
			projectile_direction,
			owner_type
		)
		
		projectile.scale *= 2
		projectile_shot.emit(projectile)
	
