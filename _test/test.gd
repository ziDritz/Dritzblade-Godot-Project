extends Node
@onready var label: Label = $Label
@onready var boss_shooter: BossShooter = $Boss/BossShooter
@onready var shooter: PlayerShooter = $Player/PlayerShooter


func _process(delta: float) -> void:
	label.text = "projectile_in_charger: " + str(shooter.projectile_in_charger) + ", is_projectile_ready: " + str(shooter.is_projectile_ready) + ", is_reloading: " + str(shooter.is_reloading)



func _on_boss_shot(projectile: Projectile) -> void:
	add_child(projectile)


func _on_player_shot(projectile: Projectile) -> void:
	add_child(projectile)
