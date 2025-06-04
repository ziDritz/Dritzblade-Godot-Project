class_name Game
extends Node


signal game_over

const SPACE_SHOOTER_LEVEL_SCENE = preload("res://game_world/space_shooter_level.tscn")
const WAVES_LEVEL_1_SCENE = preload("res://game_objects/wave/waves_level_1.tscn")
const WAVES_LEVEL_2_SCENE = preload("res://game_objects/wave/waves_level_2.tscn")
const WAVES_LEVEL_3_SCENE = preload("res://game_objects/wave/waves_level_3.tscn")
const SPACE_SHOOTER_LEVEL_BOSS_SCENE = preload("res://game_world/space_shooter_level_boss.tscn")

enum GameLevel { ONE, TWO, THREE, BOSS }

# Trasition variables
@export var fade_time: float
@export var await_time: float

var current_waves

@onready var game_ui: GameUI = $GameUI
@onready var space_shooter_level: SpaceShooterLevel = $SpaceShooterLevel
@onready var scene_transition_player: SceneTransitionPlayer = $SceneTransitionPlayer


func _ready():
	_go_to_level(GameLevel.ONE)

	
func _go_to_level(game_level: GameLevel):
	
	var waves: PackedScene
	var ui_text: String
	var music_string: String
	
	match game_level:
		GameLevel.ONE:
			waves = WAVES_LEVEL_1_SCENE
			ui_text = "LEVEL 1"
			music_string = "music_level_1"
			
		GameLevel.TWO:
			waves = WAVES_LEVEL_2_SCENE
			ui_text = "LEVEL 2"
			music_string = "music_level_2"
			
		GameLevel.THREE:
			waves = WAVES_LEVEL_3_SCENE
			ui_text = "LEVEL 3"
			music_string = "music_level_3"
			
		GameLevel.BOSS:
			waves = SPACE_SHOOTER_LEVEL_BOSS_SCENE
			ui_text = "BOSS LEVEL"
			music_string = "boss_music"
	
	space_shooter_level.init(waves)
	game_ui.transient_rich_text_label(ui_text)
	MusicManager.play("musics", music_string, 3.0, true)
	scene_transition_player.play_transition("level_transition/level_transition_in")
	
	
