extends StaticBody3D

@onready var light: OmniLight3D = $OmniLight3D
@onready var hummingaudio: AudioStreamPlayer3D = $hummingAudioPlayer

var turned_on: bool = false

func _ready() -> void:
	light.visible = turned_on
	if turned_on == true:
		hummingaudio.play()


func toggle_light() -> void:
	if turned_on == true:
		turned_on = false
	else:
		turned_on = true
		hummingaudio.play()
	
	light.visible = turned_on


func interact() -> void:
	toggle_light()


func _on_humming_audio_player_finished() -> void:
	if turned_on == true:
		hummingaudio.play()
