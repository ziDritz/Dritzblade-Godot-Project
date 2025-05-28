extends Control

signal game_start

func _ready() -> void:
	MusicManager.loaded.connect(on_music_manager_loaded)


func _on_button_start_pressed() -> void:
	$LevelTransition.play("level_transition_out")
	$Player.is_controlable = false


func _on_button_options_pressed() -> void:
	var options_menu = preload("res://menus/Options Menu.tscn").instantiate()
	options_menu.tree_exited.connect(_on_options_menu_tree_exited)
	owner.add_child(options_menu)
	visible = false



func _on_button_exit_pressed() -> void:
	get_tree().quit()


func _on_level_transition_animation_finished(_anim_name: StringName) -> void:
	game_start.emit()
	queue_free()
	
func on_music_manager_loaded() -> void:
	MusicManager.play("musics", "menu_music")

func _on_options_menu_tree_exited():
	visible = true


func _on_shooter_projectile_shot(projectile: Projectile) -> void:
	add_child(projectile)
