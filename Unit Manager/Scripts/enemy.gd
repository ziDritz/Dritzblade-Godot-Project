class_name Enemy extends Unit

@export var chance_to_shoot: float
@onready var shooter = $Movement/Shooter

func _ready() -> void:
	await get_tree().create_timer(randf()).timeout
	$DecisionTimer.start()

func _on_decision_timer_timeout() -> void:
	var chance = randf()
	if chance <= chance_to_shoot && shooter != null:
		shooter.shoot()
