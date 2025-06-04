extends Node

enum MainState { MAIN_MENU, PLAYING, PAUSED, GAME_OVER, ENDING }

const ENDING_SCENE = preload("res://screen_states/ending.tscn")
const GAME_SCENE = preload("res://screen_states/game.tscn")
const MAIN_MENU_SCENE = preload("res://screen_states/main_menu.tscn")

var main_menu: MainMenu
var game: Game
var ending: Ending

var current_state: MainState

@onready var scene_transition_player: SceneTransitionPlayer = $SceneTransitionPlayer


func _ready() -> void:
	MusicManager.loaded.connect(on_music_manager_loaded)
	set_state(MainState.MAIN_MENU)


func set_state(new_state):
	current_state = new_state
	match new_state:
		MainState.MAIN_MENU:
			_go_to_main_menu()
		MainState.PLAYING:
			_go_to_game()
		MainState.ENDING:
			_go_to_ending()





#func _process(_delta: float) -> void:
	#if Input.is_action_just_pressed("pause") && current_level != null:
		#if is_level_paused == false:
			#current_level.process_mode = Node.PROCESS_MODE_DISABLED
			#current_level.get_node("UI_level").visible = false
	#
			#menu_scene = MENU_SCENE.instantiate()
			#add_child(menu_scene)
#
			#is_level_paused = true
			#return
#
#
		#if is_level_paused == true:
			#menu_scene.queue_free()
			#
			#current_level.get_node("UI_level").visible = true
			#current_level.process_mode = Node.PROCESS_MODE_INHERIT	
			#
			#is_level_paused = false
			#return


func _go_to_main_menu():
	if game != null: game.queue_free()
	if ending != null: ending.queue_free()
	
	main_menu = MAIN_MENU_SCENE.instantiate()
	main_menu.button_start_pressed.connect(_on_main_menu_button_start_pressed)
	add_child(main_menu)

	
func _go_to_game():
	scene_transition_player.transition_fade_out()
	await scene_transition_player.animation_finished
	
	if main_menu != null: main_menu.queue_free()
	if ending != null: ending.queue_free()
	
	game = GAME_SCENE.instantiate()
	add_child(game)
	
	scene_transition_player.transition_fade_in()
	
	
func _go_to_ending():
	pass

func on_music_manager_loaded() -> void:
	MusicManager.play("musics", "menu_music")


#func _on_final_screen_cleared():
	#current_level = MAIN_MENU_SCENE.instantiate()
	#add_child(current_level)


func _on_main_menu_button_start_pressed() -> void:
	_go_to_game()
	
	
