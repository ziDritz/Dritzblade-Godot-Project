extends CanvasLayer



func _on_timer_level_timeout() -> void:
	var rich_text_label_fade_out = RichTextLabelFadeOut.new()
	get_child(0).add_child(rich_text_label_fade_out)
