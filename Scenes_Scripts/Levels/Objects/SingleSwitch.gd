extends Node3D

@onready var anim: AnimationPlayer = $AnimationPlayer


@export var switch_object: Node3D

@export var switch_on: bool = false

func _ready() -> void:
	if switch_on == true:
		switch_object_interact()
		anim.play("")


##
func toggle_switch() -> void:
	if switch_on == true:
		switch_on = false
		anim.play("off")
	else:
		switch_on = true
		anim.play("on")
	
	switch_object_interact()


func switch_object_interact() -> void:
	if switch_object != null:
		if switch_object.has_method("interact"):
			switch_object.interact()


func _on_interactable_interact() -> void:
	toggle_switch()
