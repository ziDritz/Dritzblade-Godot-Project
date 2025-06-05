extends Node


# Pendulum movement variables
@export var amplitude: float # The maximum distance the enemy moves from the center
@export var frequency: float # The speed of the pendulum movement

var pendulum_velocity: Vector2 = Vector2.ZERO

@onready var parent: Node2D = $".."


func _physics_process(delta):

		## Calculate the pendulum offset using a sine wave
	var pendulum_offset: float = amplitude * sin(frequency * Time.get_ticks_msec() / 1000.0)
	parent.position += Vector2(pendulum_offset,0) * delta
