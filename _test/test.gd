extends Node
@onready var label: Label = $Label


func _ready() -> void:
	await MusicManager.loaded
	MusicManager.play("musics", "main_menu")





func _on_boss_shot(projectile: Projectile) -> void:
	add_child(projectile)


func _on_player_shot(projectile: Projectile) -> void:
	add_child(projectile)


func _on_music_volume_value_changed(value: float) -> void:
	pass

func _on_sound_volume_value_changed(value: float) -> void:
	$VBoxContainer/Label.text = "SFX_slide_value: " + str(value)
	$VBoxContainer/Label.text = "SFX_slide_to_DB: " + str(linear_to_db(value))
	$VBoxContainer/Label.text = "SFX_slide_value: " + str(value)
	#value = db_to_linear(AudioServer.get_bus_volume_db(audio_bus_id))
	#AudioServer.set_bus_volume_db(audio_bus_id, slider_value)
