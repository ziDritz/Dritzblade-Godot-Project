class_name GameUI
extends CanvasLayer

signal retry_requested
signal main_menu_requested

@export var fade_time: float
@export var await_time: float

@onready var rich_text_label = $RichTextLabel
@onready var pause_menu: OptionsMenu = $PauseMenu
@onready var game_over: GameOver = $GameOver
@onready var boss_life_bar: TextureProgressBar = $BossLifeBar


func transient_rich_text_label(text: String) -> void:
	rich_text_label.text = "[font size=54][highlight]" + text
	rich_text_label.visible = true
	rich_text_label.modulate.a = 0.0  # Start fully transparent

	# Fade in
	var tween := create_tween()
	tween.tween_property(rich_text_label, "modulate:a", 1.0, fade_time)
	await tween.finished

	# Wait visible time
	await get_tree().create_timer(await_time).timeout

	# Fade out
	var tween_out := create_tween()
	tween_out.tween_property(rich_text_label, "modulate:a", 0.0, fade_time)
	await tween_out.finished

	rich_text_label.visible = false


func set_boss_ui(boss: CharacterBody2D):
	boss_life_bar.init(boss)
	boss_life_bar.visible = true
	
	
func set_pause(_bool: bool):
	pause_menu.visible = _bool
	
	
func set_game_over():
	rich_text_label.visible = false
	game_over.visible = true



func _on_game_over_retry_button_pressed() -> void:
	retry_requested.emit()
	game_over.visible = false

func _on_game_over_main_menu_button_pressed() -> void:
	main_menu_requested.emit()
	game_over.visible = false


	
