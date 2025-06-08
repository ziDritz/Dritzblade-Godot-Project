extends HSlider


var audio_bus_name: String = "SFX"
var audio_bus_id: int

@onready var audio_stream_player: AudioStreamPlayer = $"../../AudioStreamPlayer"


func _ready() -> void:
	audio_bus_id = AudioServer.get_bus_index(audio_bus_name)
	value = AudioServer.get_bus_volume_db(audio_bus_id)
	self.value_changed.connect(_on_value_changed)
	# on connect manuellement après initialisation
	# sinon un son est joué 

func _on_value_changed(slider_value: float) -> void:
	AudioServer.set_bus_volume_db(audio_bus_id, slider_value)
	audio_stream_player.play()
