extends Node3D

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var click_audio: AudioStreamPlayer3D = $ClickAudioPlayer

@export var switch_object: Node3D

@export var switch_on: bool = false



var is_focused: bool = false
@export var focused_meshes: Array[MeshInstance3D]


var can_be_int: bool = false

func _ready() -> void:
	if switch_on == true:
		switch_object_interact()
		anim.play("on")


##
func interact() -> void:
	if switch_on == true:
		switch_on = false
		anim.play("off")
	else:
		switch_on = true
		anim.play("on")
	
	click_audio.play()
	switch_object_interact()


func switch_object_interact() -> void:
	if switch_object != null:
		if switch_object.has_method("interact"):
			switch_object.interact()


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
