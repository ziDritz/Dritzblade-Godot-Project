class_name Game
extends Node


signal main_menu_requested
signal game_ended

const SPACE_SHOOTER_LEVEL_SCENE = preload("res://game_world/space_shooter_level.tscn")
const WAVES_LEVEL_1_SCENE = preload("res://game_objects/wave/waves_level_1.tscn")
const WAVES_LEVEL_2_SCENE = preload("res://game_objects/wave/waves_level_2.tscn")
const WAVES_LEVEL_3_SCENE = preload("res://game_objects/wave/waves_level_3.tscn")
const BOSS_PATH_2D_SCENE = preload("res://game_objects/boss/boss_path_2d.tscn")

enum GameLevel { ONE, TWO, THREE, BOSS }

var current_game_level: GameLevel
var current_packed_scene
var is_game_paused: bool = false

@onready var game_ui: GameUI = $GameUI
@onready var space_shooter_level: SpaceShooterLevel = $SpaceShooterLevel
@onready var scene_transition_player: SceneTransitionPlayer = $SceneTransitionPlayer


func _input(event):
	if event.is_action_pressed("pause"):
		if is_game_paused == false:
			_set_pause(true)
			return
		elif is_game_paused == true:
			_set_pause(false)
			return


func start_game():
	_go_to_level(GameLevel.BOSS)


func _go_to_level(game_level: GameLevel):
	
	var packed_scene: PackedScene
	var level_type: String
	var ui_text: String
	var music_string: String
	
	match game_level:
		GameLevel.ONE:
			packed_scene = WAVES_LEVEL_1_SCENE
			level_type = "Waves"
			ui_text = "LEVEL 1"
			music_string = "music_level_1"
			
		GameLevel.TWO:
			packed_scene = WAVES_LEVEL_2_SCENE
			level_type = "Waves"
			ui_text = "LEVEL 2"
			music_string = "music_level_2"
			
		GameLevel.THREE:
			packed_scene = WAVES_LEVEL_3_SCENE
			level_type = "Waves"
			ui_text = "LEVEL 3"
			music_string = "music_level_3"
			
		GameLevel.BOSS:
			packed_scene = BOSS_PATH_2D_SCENE
			level_type = "Boss"
			ui_text = "BOSS LEVEL"
			music_string = "boss_music"
	
	if level_type == "Waves":
		space_shooter_level.init(packed_scene, "Waves", game_level)
	if level_type == "Boss":
		space_shooter_level.init(packed_scene, "Boss", game_level)
		game_ui.set_boss_ui(space_shooter_level.boss)
		
	game_ui.transient_rich_text_label(ui_text)
	MusicManager.play("musics", music_string, 3.0, true)
	scene_transition_player.play_transition("animation_ressources/fade_in")
	space_shooter_level.animate_player_in()

	current_game_level = game_level
	
	
func _set_pause(_bool: bool):
	if _bool == true:
		space_shooter_level.process_mode = Node.PROCESS_MODE_DISABLED
		game_ui.set_pause(true)	
		is_game_paused = true
	
	if _bool == false:
		space_shooter_level.process_mode = Node.PROCESS_MODE_INHERIT
		game_ui.set_pause(false)	
		is_game_paused = false


func _on_space_shooter_level_game_over() -> void:
	game_ui.set_game_over()


func _on_space_shooter_level_level_cleared(_current_game_level) -> void:
	
	# Transition out
	game_ui.transient_rich_text_label("LEVEL CLEARED")
	await get_tree().create_timer(2.0).timeout
	space_shooter_level.animate_player_out()
	await get_tree().create_timer(2.0).timeout
	scene_transition_player.play_transition("animation_ressources/fade_out")
	await scene_transition_player.animation_finished

	if space_shooter_level.player == null: return
		
	match _current_game_level:
		GameLevel.ONE:
			_go_to_level(GameLevel.TWO)
			
		GameLevel.TWO:
			_go_to_level(GameLevel.THREE)
			
		GameLevel.THREE:
			_go_to_level(GameLevel.BOSS)
			
		GameLevel.BOSS:
			game_ended.emit()


func _on_game_ui_retry_requested() -> void:
	_go_to_level(current_game_level)


func _on_game_ui_main_menu_requested() -> void:
	main_menu_requested.emit()
