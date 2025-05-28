class_name Boss extends Unit

@export var path_2D: Path2D
@export var path_follow_2D: PathFollow2D
@export var shooter: Shooter

@export var speed_move_entrance: int
@export var speed_move_1: int
@export var speed_move_2: int

func _ready() -> void:
	path_follow_2D.progess_path(speed_move_entrance)

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_Z:
			move_1()
		if event.pressed and event.keycode == KEY_E:
			move_2()

func move_1():
	path_2D.curve = preload("res://Level System/Boss Curves/move 1.tres")
	path_follow_2D.progess_path(speed_move_1)

	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = 1.0
	timer.one_shot = false
	timer.timeout.connect(shooter.shoot)
	timer.start()

func move_2():
	path_2D.curve = preload("res://Level System/Boss Curves/move 2.tres")
	path_follow_2D.progess_path(speed_move_2)
