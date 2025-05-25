extends Line2D

var formation_point_position_array: Array[Vector2]
var segment_length: Vector2
var inter_segment_length: Vector2
var point_count: int
var formation_point_position_array_index: int = 0
var start_point: Vector2
var end_point: Vector2

func _ready() -> void:
	# Set formation_point_position_array
	point_count = $"..".wave_size
	start_point = get_point_position(0)
	end_point = get_point_position(1)
	segment_length = end_point - start_point
	inter_segment_length = segment_length / (point_count - 1) 

	for i in point_count :
		formation_point_position_array.append(start_point + i * inter_segment_length)


func _on_follow_2d_progess_ratio_ended(end_position: Vector2, unit: Unit) -> void:

	unit.get_node("Movement").position = end_position
	unit.get_node("Movement").destination = formation_point_position_array[formation_point_position_array_index]
	formation_point_position_array_index += 1
	add_child(unit) 

func _on_follow_2D_ratio_ended_without_follower() -> void:
		formation_point_position_array_index += 1

func _on_path_2d_path_follow_2d_instanciated(path_follow_2D: Variant) -> void:
	path_follow_2D.progess_ratio_ended.connect(_on_follow_2d_progess_ratio_ended)
	path_follow_2D.progess_ratio_ended_without_follower.connect(_on_follow_2D_ratio_ended_without_follower)
