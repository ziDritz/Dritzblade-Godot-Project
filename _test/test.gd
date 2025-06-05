extends Node

var x = 5

func _ready() -> void:
	if x < 10:
		return
	print("10")
