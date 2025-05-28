extends AnimatedSprite2D


func _ready() -> void:
	frame = 0

func _on_health_died(_character_body_2D) -> void:
	play("die")
