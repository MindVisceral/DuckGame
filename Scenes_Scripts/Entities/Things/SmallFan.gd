extends RigidBody3D




## Contains Strings, which are taken by the MonologueUI Node, which displays them in the
## Player's monologue box
@export var monologue_data: Array[String]
## How long before the first line gets shown on screen
@export var monologue_first_line_time: float = 0.0





@onready var animPlayer: AnimationPlayer = $AnimationPlayer
@onready var fan_audio: AudioStreamPlayer3D = $fan_AudioPlayer
@onready var click_audio: AudioStreamPlayer3D = $click_AudioPlayer

@export var turned_on: bool = false

func _ready() -> void:
	speen()

func speen() -> void:
	if turned_on == true:
		turned_on = false
		animPlayer.play("speen")
		fan_audio.play()
	else:
		turned_on = true
		animPlayer.pause()
		fan_audio.stop()
	
	click_audio.play()


func _on_interactable_interact() -> void:
	speen()
