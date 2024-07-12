extends StaticBody3D



## Contains Strings, which are taken by the MonologueUI Node, which displays them in the
## Player's monologue box
@export var monologue_data: Array[String]
## How long before the first line gets shown on screen
@export var monologue_first_line_time: float = 0.0






@onready var animPlayer: AnimationPlayer = $AnimationPlayer
@onready var fan_audio1: AudioStreamPlayer3D = $"1fan_AudioPlayer"
@onready var fan_audio2: AudioStreamPlayer3D = $"2fan_AudioPlayer"

var turned_on: bool = false
@export var spinning_clockwise: bool = true


var is_focused: bool = false
@export var focused_meshes: Array[MeshInstance3D]


func toggle_fan() -> void:
	if turned_on == true:
		turned_on = false
		animPlayer.pause()
		fan_audio1.stop()
		fan_audio2.stop()
	else:
		turned_on = true
		
		if spinning_clockwise == true:
			animPlayer.play("speen_warm")
		else:
			animPlayer.play_backwards("speen_warm")
		
		fan_audio1.play()
		fan_audio2.play()

func interact() -> void:
	toggle_fan()




func _on_1fan_audio_player_finished() -> void:
	if turned_on:
		fan_audio1.play()


func _on_2fan_audio_player_finished() -> void:
	if turned_on:
		fan_audio2.play()




func _on_interactable_focused() -> void:
	is_focused = true
	switch_shader()

func _on_interactable_unfocused() -> void:
	is_focused = false
	switch_shader()


func switch_shader() -> void:
	for mesh in focused_meshes:
		mesh.material_overlay.set_shader_parameter("enabled", is_focused)
		
		if is_focused == false:
			mesh.material_overlay.set_shader_parameter("enabled", false)
