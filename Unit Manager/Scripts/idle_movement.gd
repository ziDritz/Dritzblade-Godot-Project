extends Node

@onready var parent: Node2D = $".."

# Pendulum movement variables
var amplitude: float = 20.0  # The maximum distance the enemy moves from the center
var frequency: float = 6.0    # The speed of the pendulum movement
var pendulum_velocity: Vector2 = Vector2.ZERO

func _physics_process(delta):

		## Calculate the pendulum offset using a sine wave
	var pendulum_offset: float = amplitude * sin(frequency * Time.get_ticks_msec() / 1000.0)
	parent.position += Vector2(pendulum_offset,0) * delta
