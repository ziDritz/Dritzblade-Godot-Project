class_name Enemy extends CharacterBody2D

@export var chance_to_shoot: float

@export var speed: float
@export var direction: Vector2
@export var destination: Vector2 = Vector2.ZERO

@onready var decision_timer: Timer = $DecisionTimer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var shooter: Shooter = $Shooter
@onready var health: Health = $Health


func _ready() -> void:
	await get_tree().create_timer(randf()).timeout
	if decision_timer != null:
		decision_timer.start()


func _process(_delta: float) -> void:
	if destination != Vector2.ZERO:
		position = position.move_toward(destination, speed)


func _on_decision_timer_timeout() -> void:
	var chance = randf()
	if chance <= chance_to_shoot && shooter != null:
		shooter.shoot()


func _on_health_died(_character_body_2D: CharacterBody2D) -> void:
	SoundManager.play("SFXs", "enemy_explosion")
	shooter.queue_free()
	decision_timer.queue_free()
	collision_shape_2d.queue_free()
	health.queue_free()


func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
