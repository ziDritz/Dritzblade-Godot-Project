extends TextureProgressBar

func _ready() -> void:
	max_value = $"../../Path2D/PathFollow2D/Boss/Health".get_max_health()
	value = max_value

func _on_health_health_changed(diff: int) -> void:
	value += diff
	print(value)
