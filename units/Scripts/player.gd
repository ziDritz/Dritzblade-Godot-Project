class_name Player extends CharacterBody2D

@export var is_controlable: bool = true

@export var speed: float
@export var direction: Vector2
@export var destination: Vector2 = Vector2.ZERO

@onready var shooter: Shooter = $Shooter
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_polygon_2d: CollisionPolygon2D = $CollisionPolygon2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var health: Health = $Health


func _process(_delta):

	if is_controlable:
		direction = Vector2(Input.get_axis("move_left", "move_right"), 0)
			
		if Input.is_action_pressed("shoot"):
			shooter.shoot()

	
func _physics_process(_delta):
	velocity = direction * speed
	move_and_slide()


func _on_health_died(_character_body_2D) -> void:
	collision_polygon_2d.queue_free()
	shooter.queue_free()

func _on_level_transition_animation_finished(anim_name: StringName) -> void:
	if anim_name == "level_transition_in": is_controlable = true
	
