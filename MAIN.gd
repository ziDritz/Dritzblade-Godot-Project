extends Node


const MAIN_MENU_SCENE: PackedScene = preload("res://Main Menu/Main Menu.tscn")
const SPACE_SHOOTER_LEVEL_1_SCENE: PackedScene = preload("res://Level System/Space Shooter Level 1.tscn")
const SPACE_SHOOTER_LEVEL_2_SCENE: PackedScene = preload("res://Level System/Space Shooter Level 2.tscn")
const SPACE_SHOOTER_LEVEL_3_SCENE: PackedScene = preload("res://Level System/Space Shooter Level 3.tscn")


var current_level

func _on_main_menu_game_start() -> void:
	current_level = SPACE_SHOOTER_LEVEL_1_SCENE.instantiate()
	current_level.level_cleared.connect(_on_level_1_cleared)
	current_level.modulate.v = 0
	add_child(current_level)


func _on_level_1_cleared():
	current_level = SPACE_SHOOTER_LEVEL_2_SCENE.instantiate()
	current_level.level_cleared.connect(_on_level_2_cleared)
	add_child(current_level)

func _on_level_2_cleared():
	current_level = SPACE_SHOOTER_LEVEL_3_SCENE.instantiate()
	current_level.level_cleared.connect(_on_level_3_cleared)
	add_child(current_level)
	
func _on_level_3_cleared():
	#current_level = SPACE_SHOOTER_LEVEL_4_SCENE.instantiate()
	#current_level.level_cleared.connect(_on_level_4_cleared)
	add_child(current_level)
