class_name Shooter extends Node2D

signal projectile_shot(projectile: Projectile)

const PROJECTILE_SCENE: PackedScene = preload("res://projectiles/Scene/Projectile.tscn")

@export var projectile_resource : ProjectileResource = preload("res://projectiles/Resources/auto_cannon_resource.tres")
@export var fire_rate : float

var is_projectile_ready: bool = true

@onready var muzzle: Marker2D = $"Muzzle"


func shoot():
	if is_projectile_ready:
		var projectile: Projectile = PROJECTILE_SCENE.instantiate()
		projectile.projectile_resource = projectile_resource
		projectile.shooter = self
		
		if owner is Player: 
			projectile.direction = Vector2.UP
			projectile.position = global_position + muzzle.position
		
		if owner is Enemy: 
			projectile.direction = Vector2.DOWN
			projectile.rotation = 180.0
			projectile.position = global_position - muzzle.position
		
		projectile.shooter_owner = get_parent()
		projectile.shooter_owner_type = get_parent().get_script().get_global_name()
		$Timer.start(fire_rate)
		is_projectile_ready = false
		
		projectile_shot.emit(projectile)

func _on_timer_timeout() -> void:
	is_projectile_ready = true
	
