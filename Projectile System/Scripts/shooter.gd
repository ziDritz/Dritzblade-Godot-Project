class_name Shooter extends Node2D

signal projectile_created(projectile: Projectile)

@onready var muzzle: Marker2D = $"Muzzle"

@export var projectile_resource : ProjectileResource = preload("res://Projectile System/Resources/auto_cannon_resource.tres")

var projectile_scene: PackedScene = preload("res://Projectile System/Scene/Projectile.tscn")
var spawn_projectile_pos: Vector2 = Vector2(0,-50)
var fire_rate : float
var is_projectile_ready: bool = true

func shoot():
	if is_projectile_ready:
		var projectile: Projectile = projectile_scene.instantiate()
		projectile.projectile_resource = projectile_resource
		projectile.direction = Vector2(
			sin(deg_to_rad(get_parent().rotation)),  
			-cos(deg_to_rad(get_parent().rotation))
		)
		projectile.rotation = get_parent().rotation
		projectile.shooter_owner = get_parent()
		projectile.shooter_owner_class = get_parent().get_parent().get_script().get_global_name()
		projectile.position = global_position + muzzle.position
		print("shooter_class : " + str(projectile.shooter_owner_class))
		#projectile.shooter_owner_class = 
		print("projectile.direction : " + str(projectile.direction))
		print("projectile.rotation : " + str(projectile.rotation))
		#if get_parent().get_parent() is Player:
			#projectile.position = global_position + spawn_projectile_pos
			#projectile.direction = Vector2(0, -1)
			#
		#if get_parent().get_parent() is Enemy:
			#projectile.position = global_position + spawn_projectile_pos * -1
			#projectile.direction = Vector2(0, 1)
			#projectile.rotation = deg_to_rad(180)
		
		projectile.shooter = self
		get_parent().get_parent().get_parent().add_child(projectile)

		
		$Timer.start(projectile.fire_rate)
		is_projectile_ready = false
		

func _on_timer_timeout() -> void:
	is_projectile_ready = true
	
