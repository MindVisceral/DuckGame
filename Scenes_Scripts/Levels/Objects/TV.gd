extends RigidBody3D

## Contains Strings, which are taken by the MonologueUI Node, which displays them in the
## Player's monologue box
@export var monologue_data: Array[String]
## How long before the first line gets shown on screen
@export var monologue_first_line_time: float = 0.0
## The time before you can move on to the next line after a line shows up on the screen 
@export var monologue_line_time: Array[float]

##
@onready var noise_texture: Sprite3D = $NoiseSprite
##
@onready var staticaudio: AudioStreamPlayer3D = $StaticAudioPlayer
##
@onready var TV_light: SpotLight3D = $SpotLight3D
## Point (in seconds) at which the music was turned off
var pause_position = 0

## Is the TV turned on right now?
@export var turned_on: bool = false


var rng = RandomNumberGenerator.new()


func _ready() -> void:
	noise_texture.visible = false
	TV_light.visible = false


func _process(delta: float) -> void:
	if turned_on == true:
		noise_texture.texture.noise.offset.x = delta * rng.randf_range(-9999, 9999)
		noise_texture.texture.noise.offset.y = delta * rng.randf_range(-9999, 9999)


func toggle_TV() -> void:
	if turned_on == true:
		turned_on = false
		
		noise_texture.visible = false
		## At which second was the sound paused?
		pause_position = staticaudio.get_playback_position()
		staticaudio.stop()
		TV_light.visible = false
	else:
		turned_on = true
		
		noise_texture.visible = true
		staticaudio.play(pause_position)
		TV_light.visible = true




func _on_interactable_interact() -> void:
	toggle_TV()


func _on_static_audio_player_finished() -> void:
	if turned_on:
		staticaudio.play()
