extends RigidBody3D

## Contains Strings, which are taken by the MonologueUI Node, which displays them in the
## Player's monologue box
@export var monologue_data: Array[String]

@onready var staticaudio: AudioStreamPlayer3D = $StaticAudioPlayer
## Point (in seconds) at which the music was turned off
var pause_position = 0

## Is the TV turned on right now?
@export var turned_on: bool = false

func toggle_TV() -> void:
	if turned_on == true:
		turned_on = false
		## At which second was the music paused?
		pause_position = staticaudio.get_playback_position()
		staticaudio.stop()
	else:
		turned_on = true
		
		staticaudio.play(pause_position)




func _on_interactable_interact() -> void:
	toggle_TV()


func _on_static_audio_player_finished() -> void:
	if turned_on:
		staticaudio.play()
