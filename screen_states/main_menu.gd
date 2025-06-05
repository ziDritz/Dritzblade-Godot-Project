class_name MainMenu
extends Control

signal button_start_pressed

@onready var button_v_box_container: VBoxContainer = $ButtonVBoxContainer
@onready var options_menu: Control = $OptionsMenu
@onready var player: Player = $Player
@onready var player_animation_player: AnimationPlayer = $PlayerAnimationPlayer

enum MainMenuState { MAIN_MENU, OPTIONS }

var current_state = MainMenuState.MAIN_MENU


func set_state(new_state):
	current_state = new_state
	match new_state:
		MainMenuState.MAIN_MENU:
			_show_main_menu()
		MainMenuState.OPTIONS:
			_show_options()


func _process(_delta: float) -> void:
	if current_state == MainMenuState.OPTIONS:
		if Input.is_action_just_pressed("back"):
			set_state(MainMenuState.MAIN_MENU)


func _show_main_menu():
	button_v_box_container.visible = true
	options_menu.visible = false
	
	
func _show_options():
	button_v_box_container.visible = false
	options_menu.visible = true


func _on_start_game_button_pressed() -> void:
	button_start_pressed.emit()
	player.is_controlable = false


func _on_button_options_pressed() -> void:
	set_state(MainMenuState.OPTIONS)


func _on_button_exit_pressed() -> void:
	get_tree().quit()


func animate_player_out():
	player_animation_player.play("player_transitions/player_transition_out")


func _on_player_shot(projectile: Projectile) -> void:
	add_child(projectile)
