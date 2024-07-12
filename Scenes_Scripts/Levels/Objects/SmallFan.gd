extends RigidBody3D

@onready var animPlayer: AnimationPlayer = $AnimationPlayer

@export var turned_on: bool = false

func _ready() -> void:
	speen()

func speen() -> void:
	if turned_on == true:
		turned_on = false
		animPlayer.play("speen")
	else:
		turned_on = true
		animPlayer.pause()


func _on_interactable_interact() -> void:
	speen()
