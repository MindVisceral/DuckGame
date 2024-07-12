extends Node3D

@onready var leftAnim: AnimationPlayer = $LeftAnimationPlayer
@onready var rightAnim: AnimationPlayer = $RightAnimationPlayer
@onready var click_audio: AudioStreamPlayer3D = $ClickAudioPlayer

@export var left_switch_object: Node3D
@export var right_switch_object: Node3D

@export var left_switch_on: bool = false
@export var right_switch_on: bool = false



var is_focused: bool = false
@export var focused_meshes: Array[MeshInstance3D]


var can_be_int: bool = false

func _ready() -> void:
	if left_switch_on == true:
		#left_switch_object_interact()
		leftAnim.play("left_on")
	
	if right_switch_on == true:
		#right_switch_object_interact()
		rightAnim.play("right_on")


func interact() -> void:
	pass


##
func toggle_left_switch() -> void:
	if left_switch_on == true:
		left_switch_on = false
		leftAnim.play("left_off")
	else:
		left_switch_on = true
		leftAnim.play("left_on")
	
	click_audio.play()
	left_switch_object_interact()
#
func toggle_right_switch() -> void:
	if right_switch_on == true:
		right_switch_on = false
		rightAnim.play("right_off")
	else:
		right_switch_on = true
		rightAnim.play("right_on")
	
	click_audio.play()
	right_switch_object_interact()


##
func right_switch_object_interact() -> void:
	if right_switch_object != null:
		if right_switch_object.has_method("interact"):
			right_switch_object.interact()
#
func left_switch_object_interact() -> void:
	if left_switch_object != null:
		if left_switch_object.has_method("interact"):
			left_switch_object.interact()


##
func _on_switch_left_interact() -> void:
	toggle_left_switch()
#
func _on_switch_right_interact() -> void:
	toggle_right_switch()



func _on_interactable_left_focused() -> void:
	is_focused = true
	switch_shader()

func _on_interactable_left_unfocused() -> void:
	is_focused = false
	switch_shader()



func _on_interactable_right_focused() -> void:
	is_focused = true
	switch_shader()

func _on_interactable_right_unfocused() -> void:
	is_focused = false
	switch_shader()

func switch_shader() -> void:
	for mesh in focused_meshes:
		mesh.material_overlay.set_shader_parameter("enabled", is_focused)
		
		if is_focused == false:
			mesh.material_overlay.set_shader_parameter("enabled", false)
