extends AudioStreamPlayer

var playback
var sound
var audio_stream

func _ready() -> void:
	stream = AudioStreamPolyphonic.new()
	stream.polyphony = 32

	audio_stream = preload("res://game_objects/units/assets/Explosion2.mp3")
	
	#playback = get_stream_playback()
	#playback.play_stream(music_level_1)
	#play()

func _on_wave_enemy_spawned(character_body_2D: CharacterBody2D):
	character_body_2D.find_child("Health").died.connect(_on_character_body_2D_died)

func _on_character_body_2D_died(_character_body_2D):
	if !playing:
		play()
	playback = get_stream_playback()
	playback.play_stream(audio_stream)
