class_name Movement extends CharacterBody2D

@export var speed: float = 10
@export var force: float = 500
@export var direction: Vector2
var controlled_velocity: Vector2
@export var destination: Vector2 = Vector2.ZERO

func _physics_process(_delta):
	velocity = direction * force
	move_and_slide()

func _process(_delta: float) -> void:
	move_to_destination()

func move_to_destination():
	if destination != Vector2.ZERO:
		position = position.move_toward(destination, speed)


func _on_health_died(_unit) -> void:
	$CollisionShape2D.queue_free()
	$Shooter.queue_free()
