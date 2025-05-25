class_name Shooter extends Node2D

var projectile_scene: PackedScene = preload("res://Projectile System/Scene/Projectile.tscn")
var projectile_resource : ProjectileResource = preload("res://Projectile System/Resources/auto_cannon_resource.tres")
var spawn_projectile_pos: Vector2 = Vector2(0,-50)
var fire_rate : float
var is_projectile_ready: bool = true


func shoot():
	if is_projectile_ready:
		var projectile = projectile_scene.instantiate()
		projectile.Projectile_resource = projectile_resource
		
		if get_parent().get_parent() is Player:
			projectile.position = global_position + spawn_projectile_pos
			projectile.direction = Vector2(0, -1)
			
		if get_parent().get_parent() is Enemy:
			projectile.position = global_position + spawn_projectile_pos * -1
			projectile.direction = Vector2(0, 1)
			projectile.rotation = deg_to_rad(180)
		
		projectile.shooter = self
		get_parent().get_parent().get_parent().add_child(projectile)

		
		$Timer.start(projectile.fire_rate)
		is_projectile_ready = false
		

func _on_timer_timeout() -> void:
	is_projectile_ready = true
