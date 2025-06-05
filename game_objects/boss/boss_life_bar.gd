extends TextureProgressBar

func init(_boss: CharacterBody2D) -> void:
	max_value = _boss.get_node("Health").get_max_health()
	value = max_value
	_boss.get_node("Health").health_changed.connect(_on_health_health_changed)

func _on_health_health_changed(diff: int) -> void:
	value += diff
