extends StaticBody3D

## Contains Strings, which are taken by the MonologueUI Node, which displays them in the
## Player's monologue box
@export var monologue_data: Array[String]
## How long before the first line gets shown on screen
@export var monologue_first_line_time: float = 0.0


@onready var click_audio: AudioStreamPlayer3D = $click_AudioPlayer


func _on_interactable_interact() -> void:
	click_audio.play()
