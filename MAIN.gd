extends Node

const MAIN_MENU_SCENE: PackedScene = preload("res://menus/Main Menu.tscn")
const SPACE_SHOOTER_LEVEL_1_SCENE: PackedScene = preload("res://level_system/level/Space Shooter Level 1.tscn")
const SPACE_SHOOTER_LEVEL_2_SCENE: PackedScene = preload("res://level_system/level/Space Shooter Level 2.tscn")
const SPACE_SHOOTER_LEVEL_3_SCENE: PackedScene = preload("res://level_system/level/Space Shooter Level 3.tscn")
const SPACE_SHOOTER_BOSS_LEVEL_SCENE: PackedScene = preload("res://level_system/boss/Space Shooter Boss Level.tscn")
const MENU_SCENE: PackedScene = preload("res://menus/Options Menu.tscn")

var current_level
var menu_scene
var is_level_paused = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause") && current_level != null:
		if is_level_paused == false:
			current_level.process_mode = Node.PROCESS_MODE_DISABLED
			current_level.get_node("UI_level").visible = false
	
			menu_scene = MENU_SCENE.instantiate()
			add_child(menu_scene)

			is_level_paused = true
			return


		if is_level_paused == true:
			menu_scene.queue_free()
			
			current_level.get_node("UI_level").visible = true
			current_level.process_mode = Node.PROCESS_MODE_INHERIT	
			
			is_level_paused = false
			return


func _on_main_menu_game_start() -> void:
	#current_level = SPACE_SHOOTER_LEVEL_1_SCENE.instantiate()
	#current_level.level_transition_animation_out_finished.connect(_on_level_1_cleared)
	#current_level.modulate.v = 0
	#MusicManager.play("musics", "music_level_1", 3.0, true)
	#add_child(current_level)

	current_level = SPACE_SHOOTER_BOSS_LEVEL_SCENE.instantiate()
	#current_level.level_transition_animation_out_finished.connect(_on_level_3_cleared)
	current_level.modulate.v = 0
	MusicManager.play("musics", "boss_music", 3.0, true)
	add_child(current_level)


func _on_level_1_cleared():
	current_level = SPACE_SHOOTER_LEVEL_2_SCENE.instantiate()
	current_level.level_transition_animation_out_finished.connect(_on_level_2_cleared)
	add_child(current_level)
	MusicManager.play("musics", "music_level_2", 3.0, true)

func _on_level_2_cleared():
	current_level = SPACE_SHOOTER_LEVEL_3_SCENE.instantiate()
	current_level.level_transition_animation_out_finished.connect(_on_level_3_cleared)
	MusicManager.play("musics", "music_level_3", 3.0, true)
	add_child(current_level)
	
func _on_level_3_cleared():
	current_level = SPACE_SHOOTER_BOSS_LEVEL_SCENE.instantiate()
	#current_level.level_transition_animation_out_finished.connect(_on_level_3_cleared)
	MusicManager.play("musics", "boss_music", 3.0, true)
	add_child(current_level)
