extends AudioStreamPlayer2D



func _on_health_died(_character_body_2D: CharacterBody2D) -> void:
	SoundManager.play("SFXs", "explosion")
