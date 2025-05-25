extends PathFollow2D

var path_speed = 500
var child_unit: Unit

signal progess_ratio_ended(end_position: Vector2, unit: Unit)
signal progess_ratio_ended_without_follower()

func _process(delta: float) -> void:
	progress += path_speed * delta
	if progress_ratio == 1.0:
		var curve = get_parent().curve
		
		if child_unit == null:
			progess_ratio_ended_without_follower.emit()
		else:
			remove_child(child_unit)
			progess_ratio_ended.emit(curve.get_point_position(curve.point_count-1), child_unit)
		
		queue_free()
