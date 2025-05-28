extends AudioStreamPlayer2D



func _on_health_died(unit: Unit) -> void:
	SoundManager.play("SFXs", "explosion")
