extends Path2D

var path_speed: int = 1000

signal path_follow_2D_instanciated(path_follow_2D)

func path_follow_2D_init(unit: Unit):
	var path_follow_2D = PathFollow2D.new()
	path_follow_2D.loop = false
	path_follow_2D.set_script(preload("res://Level System/path_follow_2D_extension.gd"))
	path_follow_2D.child_unit = unit
	path_follow_2D.add_child(unit)
	add_child(path_follow_2D)
	path_follow_2D_instanciated.emit(path_follow_2D)
