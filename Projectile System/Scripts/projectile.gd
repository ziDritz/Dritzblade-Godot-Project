class_name Projectile extends Area2D

var Projectile_resource: ProjectileResource

var texture: Texture2D
var sound: AudioStreamMP3
var damage : int
var fire_rate : float
var speed: int

var direction: Vector2 = Vector2(0, -1)
var shooter
var shooter_class

func _ready() -> void:	
	name = Projectile_resource.name
	$AnimatedSprite2D.sprite_frames = Projectile_resource.sprite_frames
	$AudioStreamPlayer.stream = Projectile_resource.sound
	damage = Projectile_resource.damage
	fire_rate = Projectile_resource.fire_rate	
	speed = Projectile_resource.speed

	$AnimatedSprite2D.play()
	$AudioStreamPlayer.play()

	shooter_class = shooter.get_parent().get_parent().get_script().get_global_name()

func _physics_process(delta: float) -> void:
	position += direction * speed * delta
	
	
	if not Rect2(-500, -500, 3500, 3500).has_point(global_position):
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	var target_class = body.get_parent().get_script().get_global_name()
	
	if body.get_parent().has_node("Health") && target_class != shooter_class:
		body.get_parent().get_node("Health").die()
		queue_free()
