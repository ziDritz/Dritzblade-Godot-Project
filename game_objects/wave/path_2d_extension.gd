extends Path2D

signal path_follow_2D_instanciated(path_follow_2D)

const PATH_FOLLOW_2D_EXTENSION_SCRIPT = preload("res://game_objects/wave/path_follow_2D_extension.gd")

var path_speed: int = 1000


func path_follow_2D_init(character_body_2D: CharacterBody2D):
	var path_follow_2D = PathFollow2D.new()
	path_follow_2D.loop = false
	path_follow_2D.set_script(PATH_FOLLOW_2D_EXTENSION_SCRIPT)
	
	if character_body_2D.get_parent() != null:
		character_body_2D.reparent(path_follow_2D)
	else:
		path_follow_2D.child_character_body_2D = character_body_2D
		path_follow_2D.add_child(character_body_2D)
	add_child(path_follow_2D)
	path_follow_2D_instanciated.emit(path_follow_2D)
