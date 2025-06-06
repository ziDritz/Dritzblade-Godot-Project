class_name ChargerDisplay
extends VBoxContainer

const AMMO_DISPLAY_SPRITE = preload("res://game_objects/projectiles/Assets/ammo_display_sprite.png")

@export var player_shooter: PlayerShooter

var ammo_display_array: Array

func _ready() -> void:
	for i in player_shooter.charger_capacity:
		var ammo_display = TextureRect.new()
		ammo_display.texture = AMMO_DISPLAY_SPRITE
		ammo_display_array.append(ammo_display)
		add_child(ammo_display)
		ammo_display.modulate = Color(0.2, 1, 0.2)


func _on_player_shooter_projectile_in_charger_changed(projectile_in_charger: int) -> void:
	for i in ammo_display_array.size():
		if i < projectile_in_charger:
			ammo_display_array[i].visible = true
		else:
			ammo_display_array[i].visible = false
			
	if projectile_in_charger == player_shooter.charger_capacity:
		for ammo_display in ammo_display_array:
			ammo_display.modulate = Color(0.2, 1, 0.2)
	else:
		for ammo_display in ammo_display_array:
			ammo_display.modulate = Color(1, 1, 1)
	
