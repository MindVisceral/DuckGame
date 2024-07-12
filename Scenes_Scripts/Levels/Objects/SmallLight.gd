extends StaticBody3D

@onready var light: OmniLight3D = $OmniLight3D
@onready var hummingaudio: AudioStreamPlayer3D = $hummingAudioPlayer

func _process(delta: float) -> void:
	if !hummingaudio.playing and light.visible:
		hummingaudio.play()


func _on_humming_audio_player_finished() -> void:
	if light.visible:
		hummingaudio.play()
