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



var is_focused: bool = false
@export var focused_meshes: Array[MeshInstance3D]

var can_be_int: bool = false


func _ready() -> void:
	interact()

func interact() -> void:
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
	interact()




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
