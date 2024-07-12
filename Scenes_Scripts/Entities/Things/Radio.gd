extends RigidBody3D


## Contains Strings, which are taken by the MonologueUI Node, which displays them in the
## Player's monologue box
@export var monologue_data: Array[String]
## How long before the first line gets shown on screen
@export var monologue_first_line_time: float = 0.0



## Reference to the music player
@onready var audio: AudioStreamPlayer3D = $cacophony_AudioPlayer
@onready var click_audio: AudioStreamPlayer3D = $ClickAudioPlayer
## Point (in seconds) at which the music was turned off
var pause_position = 0


@onready var setpiecetimer: Timer = $SetpieceTimer
## References the DoorLocked setpiece script. The door will unlock when the radio is interacted with. 
@export var setpiece_script: Node
## DangerImminent setpiece scripts
@export var danger_setpiece_script: Node


## Is the radio turned on right now?
@export var turned_on: bool = false

## Toggle the radio off and on
func toggle_radio() -> void:
	if turned_on == true:
		#turned_on = false
		## At which second was the music paused?
		#pause_position = audio.get_playback_position()
		#audio.stop()
		## don't turn the radio off, actually
		pass
	else:
		turned_on = true
		
		setpiecetimer.start()
		
		audio.play(pause_position)
	
	click_audio.play()


func do_the_setpiece() -> void:
	setpiece_script.play_set_piece()
	danger_setpiece_script.play_set_piece()



##
func _on_interactable_interact() -> void:
	toggle_radio()
	Globals.cacophony_active = true

## Loop the music
func _on_audio_player_finished() -> void:
	if turned_on:
		audio.play()



func _on_setpiece_timer_timeout() -> void:
	do_the_setpiece()
