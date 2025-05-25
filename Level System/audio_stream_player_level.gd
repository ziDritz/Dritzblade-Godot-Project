extends AudioStreamPlayer

var playback
var sound
var audio_stream

var music_level_1 = preload("res://_music/game-music-by-deepmusiceveryday.mp3")
var music_level_2 = preload("res://_music/spaceship-arcade-shooter-game-background-soundtrack-by-serhii_kliets.mp3")
var music_level_3 = preload("res://_music/short-8-bit-background-music-for-video-mobile-game-old-school-by-white_records.mp3")

func _ready() -> void:
	stream = AudioStreamPolyphonic.new()
	stream.polyphony = 32

	audio_stream = preload("res://_SFX/SFXPack/Explosions/Explosion2.mp3")
	
	playback = get_stream_playback()
	playback.play_stream(music_level_1)
	play()

func _on_wave_enemy_spawned(unit: Unit):
	unit.find_child("Health").died.connect(_on_unit_died)

func _on_unit_died(_unit):
	if !playing:
		play()
	playback = get_stream_playback()
	playback.play_stream(audio_stream)
