class_name GameUI
extends CanvasLayer


@export var fade_time: float
@export var await_time: float

@onready var rich_text_label = $RichTextLabel
@onready var pause_menu: OptionsMenu = $PauseMenu
@onready var game_over: GameOver = $GameOver


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


func set_pause(_bool: bool):
	pause_menu.visible = _bool
	
	
func set_game_over():
	game_over.visible = true
