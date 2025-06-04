class_name Game
extends Node


signal game_over

const SPACE_SHOOTER_LEVEL_1 = preload("res://game_world/space_shooter_level_1.tscn")
const SPACE_SHOOTER_LEVEL_2 = preload("res://game_world/space_shooter_level_2.tscn")
const SPACE_SHOOTER_LEVEL_3 = preload("res://game_world/space_shooter_level_3.tscn")
const SPACE_SHOOTER_LEVEL_BOSS = preload("res://game_world/space_shooter_level_boss.tscn")

enum GameLevel { ONE, TWO, THREE, BOSS }

# Trasition variables
@export var fade_time: float
@export var await_time: float

var current_game_level: SpaceShooterLevel

@onready var game_ui: GameUI = $GameUI


func _ready():
	_go_to_level(GameLevel.ONE)

	
func _go_to_level(game_level: GameLevel):
	
	var scene: PackedScene
	var ui_text: String
	var music_string: String
	
	match game_level:
		GameLevel.ONE:
			scene = SPACE_SHOOTER_LEVEL_1
			ui_text = "LEVEL 1"
			music_string = "music_level_1"
			
		GameLevel.TWO:
			scene = SPACE_SHOOTER_LEVEL_2
			ui_text = "LEVEL 2"
			music_string = "music_level_2"
			
		GameLevel.THREE:
			scene = SPACE_SHOOTER_LEVEL_3
			ui_text = "LEVEL 3"
			music_string = "music_level_3"
			
		GameLevel.BOSS:
			scene = SPACE_SHOOTER_LEVEL_BOSS
			ui_text = "BOSS LEVEL"
			music_string = "boss_music"
	
	# Instanciation
	current_game_level = scene.instantiate()
	add_child(current_game_level)
	
	# UI and Music init
	game_ui.transient_rich_text_label(ui_text)
	MusicManager.play("musics", music_string, 3.0, true)
	
	
