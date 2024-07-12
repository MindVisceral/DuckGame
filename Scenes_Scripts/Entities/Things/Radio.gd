extends RigidBody3D

## Reference to the music player
@onready var audio: AudioStreamPlayer3D = $AudioPlayer
@onready var click_audio: AudioStreamPlayer3D = $ClickAudioPlayer
## Point (in seconds) at which the music was turned off
var pause_position = 0


@onready var setpiecetimer: Timer = $SetpieceTimer
## References the DoorLocked setpiece script. The door will unlock when the radio is interacted with. 
@export var setpiece_script: Node


## Is the radio turned on right now?
@export var turned_on: bool = false

## Toggle the radio off and on
func toggle_radio() -> void:
	if turned_on == true:
		turned_on = false
		## At which second was the music paused?
		pause_position = audio.get_playback_position()
		audio.stop()
	else:
		turned_on = true
		
		setpiecetimer.start()
		
		click_audio.play()
		audio.play(pause_position)


func do_the_setpiece() -> void:
	setpiece_script.play_set_piece()



##
func _on_interactable_interact() -> void:
	toggle_radio()

## Loop the music
func _on_audio_player_finished() -> void:
	if turned_on:
		audio.play()



func _on_setpiece_timer_timeout() -> void:
	do_the_setpiece()
