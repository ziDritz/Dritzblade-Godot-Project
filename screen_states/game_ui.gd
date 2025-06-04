class_name GameUI
extends CanvasLayer


@export var fade_time: float
@export var await_time: float

@onready var rich_text_label = $RichTextLabel


func transient_rich_text_label(text: String):
	rich_text_label.text = "[font size=54][highlight]" + text
	rich_text_label.visible = true

	# Fade out
	var tween: Tween = create_tween()
	tween.tween_property(rich_text_label, "modulate:a", 0.0, fade_time)
	await get_tree().create_timer(await_time).timeout
	#Fade in
	tween.tween_property(rich_text_label, "modulate:a", 1.0, fade_time)
	tween.kill()
	
	rich_text_label.visible = false


func fade_out(_fade_time: float):
	var tween: Tween = create_tween()
	tween.tween_property(rich_text_label, "modulate:a", 0.0, _fade_time)
	tween.kill()


func fade_in(_fade_time: float):
	var tween: Tween = create_tween()
	tween.tween_property(rich_text_label, "modulate:a", 1.0, _fade_time)
	tween.kill()
