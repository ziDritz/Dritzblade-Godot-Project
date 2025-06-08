extends AudioStreamPlayer


func _on_health_health_changed(diff: int) -> void:
	SoundManager.play("SFXs", "boss_hit")
