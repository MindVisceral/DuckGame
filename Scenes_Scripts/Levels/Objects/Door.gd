extends StaticBody3D

@onready var animPlayer: AnimationPlayer = $AnimationPlayer

@onready var openSound: AudioStreamPlayer3D = $openAudioPlayer

var open: bool = false
@export var is_locked: bool = true
@export var setpiece_script: Node


## Contains Strings, which are taken by the MonologueUI Node, which displays them in the
## Player's monologue box
## This are the default lines, they are changed by the DoorLocked setpiece script,
## which repalces them for somethign else
@export var monologue_data: Array[String]
## How long before the first line gets shown on screen
@export var monologue_first_line_time: float = 0.0
## The time before you can move on to the next line after a line shows up on the screen 
@export var monologue_line_time: Array[float]

func toggle_door() -> void:
	if open == false:
		if !is_locked:
			animPlayer.play("open")
			open = true
			openSound.play()


func _on_interactable_interact() -> void:
	toggle_door()
