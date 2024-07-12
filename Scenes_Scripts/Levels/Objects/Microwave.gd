extends StaticBody3D

@export var door_open: bool = false

@onready var animPlay: AnimationPlayer = $AnimationPlayer

func toggle_door() -> void:
	if door_open == true:
		door_open = false
		animPlay.play("close_door")
	else:
		door_open = true
		animPlay.play("open_door")


func _on_interactable_interact() -> void:
	toggle_door()
