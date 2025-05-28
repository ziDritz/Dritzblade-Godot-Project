class_name Shooter extends Node2D

signal projectile_shot(projectile: Projectile)

@export var projectile_resource : ProjectileResource = preload("res://projectiles/Resources/auto_cannon_resource.tres")

var projectile_scene: PackedScene = preload("res://projectiles/Scene/Projectile.tscn")
var spawn_projectile_pos: Vector2 = Vector2(0,-50)
var fire_rate : float
var is_projectile_ready: bool = true

@onready var muzzle: Marker2D = $"Muzzle"


func shoot():
	if is_projectile_ready:
		var projectile: Projectile = projectile_scene.instantiate()
		projectile.projectile_resource = projectile_resource
		
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
		
		# C'est dégeu de faire ça, j'ai essaer de mettre un signal
		# pour que le level add_child, mais la rotation du
		# projectil faisait n'importe
		#owner.get_parent().add_child(projectile)
		projectile_shot.emit(projectile)

func _on_timer_timeout() -> void:
	is_projectile_ready = true
	
