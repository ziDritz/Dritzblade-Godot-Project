class_name Player extends Unit

var controlable: bool = true

func _process(delta):

	if controlable:
		$Movement.direction = Vector2(Input.get_axis("move_left", "move_right"), 0)
			
		if Input.is_action_pressed("shoot"):
			$Movement/Shooter.shoot()
		 
