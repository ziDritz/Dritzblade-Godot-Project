extends Node2D


const MAIN_MENU_SCENE: PackedScene = preload("res://Main Menu/Main Menu.tscn")
const SPACE_SHOOTER_LEVEL_1_SCENE: PackedScene = preload("res://Level System/Space Shooter Level 1.tscn")
const SPACE_SHOOTER_LEVEL_2_SCENE: PackedScene = preload("res://Level System/Space Shooter Level 2.tscn")
const SPACE_SHOOTER_LEVEL_3_SCENE: PackedScene = preload("res://Level System/Space Shooter Level 3.tscn")


var current_level

func _on_button_start_pressed() -> void:
	pass
	
	#await get_tree().create_timer(3.0).timeout
	#
	#var tween: Tween = create_tween()
	#tween.set_ease(Tween.EASE_OUT)
	#tween.set_trans(Tween.TRANS_SINE)
	#tween.tween_property($Player.find_child("Movement"), "force", -2000, 1)
	#tween.tween_property(self, "modulate:a", 1, 1)
	#
	#current_level = MAIN_MENU_SCENE.instantiate()
	#current_level.level_cleared.connect(_on_level_3_cleared)
	#add_child(current_level)


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
