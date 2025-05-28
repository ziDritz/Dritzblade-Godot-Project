extends CanvasLayer

@onready var rich_text_label = $RichTextLabel
@onready var restart_button = $Button



func _on_timer_level_timeout() -> void:
	var rich_text_label_fade_out = RichTextLabelFadeOut.new()
	rich_text_label.add_child(rich_text_label_fade_out)


func _on_space_shooter_level_cleared() -> void:
	rich_text_label.text = "[font size=54][highlight]Level Cleared"
	rich_text_label.modulate.a = 1.0
	await get_tree().create_timer(2.0).timeout
	var rich_text_label_fade_out = RichTextLabelFadeOut.new()
	rich_text_label.add_child(rich_text_label_fade_out)



func _on_health_player_died(_character_body_2D: CharacterBody2D) -> void:
	rich_text_label.text = "[font size=54][highlight]Game Over"
	rich_text_label.modulate.a = 1.0
	restart_button.visible = true
