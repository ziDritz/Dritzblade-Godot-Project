extends PathFollow2D


var progress_max: float
var tween

signal progess_ratio_ended()


func set_progress_max():
	visible = false
	progress_ratio = 1.0
	progress_max = progress
	progress_ratio = 0.0
	visible = true


func progess_path(speed: int):
	progress_ratio = 0.0

	set_progress_max()
	var duration = progress_max / speed

	if tween:
		tween.kill()
	tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_QUAD)
	tween.tween_property(self, "progress_ratio", 1.0, duration)
	tween.tween_callback(progess_ratio_ended.emit)
