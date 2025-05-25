extends Control


func _on_button_start_pressed() -> void:
	$"../Player".controlable = false
	$"../Player".find_child("Movement").direction = Vector2(0,-1)
	$"../Player".find_child("Movement").force = 0
	var tween: Tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property($"../Player".find_child("Movement"), "force", 2000, 1)
	tween.tween_property($"..", "modulate:a", 0, 1)
	#queue_free()

func _on_button_exit_pressed() -> void:
	get_tree().quit()
