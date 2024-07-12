extends Node3D

@onready var leftAnim: AnimationPlayer = $LeftAnimationPlayer
@onready var rightAnim: AnimationPlayer = $RightAnimationPlayer

@export var left_switch_object: Node3D
@export var right_switch_object: Node3D

@export var left_switch_on: bool = false
@export var right_switch_on: bool = false

func _ready() -> void:
	if left_switch_on == true:
		left_switch_object_interact()
		leftAnim.play("left_on")
	
	if right_switch_on == true:
		right_switch_object_interact()
		rightAnim.play("right_on")


##
func toggle_left_switch() -> void:
	if left_switch_on == true:
		left_switch_on = false
		leftAnim.play("left_off")
	else:
		left_switch_on = true
		leftAnim.play("left_on")
	
	left_switch_object_interact()
#
func toggle_right_switch() -> void:
	if right_switch_on == true:
		right_switch_on = false
		rightAnim.play("right_off")
	else:
		right_switch_on = true
		rightAnim.play("right_on")
	
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
