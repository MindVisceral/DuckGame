extends StaticBody3D

@onready var WindAudio: AudioStreamPlayer3D = $WindAudioPlayer

func _ready() -> void:
	WindAudio.play()

func _on_wind_audio_player_finished() -> void:
	WindAudio.play()
