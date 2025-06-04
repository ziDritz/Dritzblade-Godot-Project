class_name BossShooter extends Node2D

signal projectile_shot(projectile: Projectile)

const PROJECTILE_SCENE = preload("res://game_objects/projectiles/Scene/Projectile.tscn")

@export var projectile_resource : ProjectileResource
@export var projectile_count : int 
@export var first_angle_side: float
@export var second_angle_side: float

@onready var muzzle: Marker2D = $"Muzzle"

func shoot():
	var angle_offset = (second_angle_side - first_angle_side) / (projectile_count - 1)
	for i in projectile_count:
		var projectile: Projectile = PROJECTILE_SCENE.instantiate()
		projectile.projectile_resource = projectile_resource
		
		var angle = first_angle_side + (angle_offset * i)
		projectile.direction = Vector2(
			sin(deg_to_rad(angle)),
			cos(deg_to_rad(angle))
		)
		projectile.scale *= 2
		projectile.position = global_position - muzzle.position
		projectile.shooter = self
		projectile.shooter_owner = get_parent()
		projectile.shooter_owner_type = get_parent().get_script().get_global_name()
		
		projectile_shot.emit(projectile)
	
