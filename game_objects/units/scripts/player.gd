class_name Player extends CharacterBody2D

signal died
signal shot(projectile: Projectile)

@export var is_controlable: bool = true
@export var speed: float
@export var direction: Vector2
@export var destination: Vector2 = Vector2.ZERO

@onready var shooter: Shooter = $Shooter
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_polygon_2d: CollisionPolygon2D = $CollisionPolygon2D
@onready var health: Health = $Health


func init():
	# Permet de reset avec une transition out
	speed = 500
	direction = Vector2.ZERO
	
	position = Vector2(960, 1180)

func _process(_delta):

	if is_controlable:
		direction = Vector2(Input.get_axis("move_left", "move_right"), 0)
			
		if Input.is_action_pressed("shoot"):
			if shooter != null: shooter.shoot()

		if Input.is_action_just_pressed("slow_down"):
			speed = 150
		
		if Input.is_action_just_released("slow_down"):
			speed = 500

	
func _physics_process(_delta):
	velocity = direction * speed
	move_and_slide()


func _on_health_died(_character_body_2D) -> void:
	#SoundManager.play("SFXs", "player_explosion")
	collision_polygon_2d.queue_free()
	shooter.queue_free()
	animated_sprite_2d.play("die") 


func _on_animated_sprite_2d_animation_finished() -> void:
	died.emit()
	queue_free()


func _on_shooter_projectile_shot(projectile: Projectile) -> void:
	shot.emit(projectile)
