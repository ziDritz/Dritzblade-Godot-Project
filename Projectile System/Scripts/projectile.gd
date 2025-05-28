class_name Projectile extends Area2D

var projectile_resource: ProjectileResource

var speed: int
var texture: Texture2D
var direction: Vector2 = Vector2(0, -1)

var sound: AudioStreamMP3
var damage : int
var fire_rate : float
var shooter
var shooter_owner
var shooter_owner_class

func _ready() -> void:	
	name = projectile_resource.name
	$AnimatedSprite2D.sprite_frames = projectile_resource.sprite_frames
	$AudioStreamPlayer.stream = projectile_resource.sound
	damage = projectile_resource.damage
	fire_rate = projectile_resource.fire_rate	
	speed = projectile_resource.speed

	$AnimatedSprite2D.play()
	$AudioStreamPlayer.play()



func _physics_process(delta: float) -> void:
	position += direction * speed * delta
	
	
	if not Rect2(-1000, -1000, 3500, 3500).has_point(global_position):
		queue_free()



func _on_body_entered(body: Node2D) -> void:
	var target_class = body.get_parent().get_script().get_global_name()
	
	if body.get_parent().has_node("Health") && target_class != shooter_owner_class:
		body.get_parent().get_node("Health").die()
		queue_free()
