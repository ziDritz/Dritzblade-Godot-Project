extends AnimatedSprite2D


func _ready() -> void:
	frame = 0

func _on_health_died(_unit) -> void:
	play("die")
