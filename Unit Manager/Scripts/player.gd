class_name Player extends Unit

@export var is_controlable: bool = true

func _process(_delta):

	if is_controlable:
		$Movement.direction = Vector2(Input.get_axis("move_left", "move_right"), 0)
			
		if Input.is_action_pressed("shoot"):
			$Movement/Shooter.shoot()
		 


func _on_level_transition_animation_finished(anim_name: StringName) -> void:
	if anim_name == "level_transition_in": is_controlable = true
	
