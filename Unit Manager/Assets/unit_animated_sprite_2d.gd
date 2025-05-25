extends AnimatedSprite2D



func _on_health_died() -> void:
	sprite_frames = preload("res://Unit Manager/Assets/Kla'ed/Destruction/TRES/Kla'ed - Scout - Destruction.tres")
	play()
