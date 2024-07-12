extends StaticBody3D

@onready var animPlayer: AnimationPlayer = $AnimationPlayer

@export var is_closed: bool = false

func _ready() -> void:
	toggle_door()

func toggle_door() -> void:
	if is_closed == true:
		is_closed = false
		animPlayer.play("close")
	else:
		is_closed = true
		animPlayer.play("open")


func _on_interactable_interact() -> void:
	toggle_door()
