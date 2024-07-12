extends StaticBody3D

@onready var animPlayer: AnimationPlayer = $AnimationPlayer

var turned_on: bool = false
@export var spinning_clockwise: bool = true

func toggle_fan() -> void:
	if turned_on == true:
		turned_on = false
		animPlayer.pause()
	else:
		turned_on = true
		
		if spinning_clockwise == true:
			animPlayer.play("speen_warm")
		else:
			animPlayer.play_backwards("speen_warm")

func interact() -> void:
	toggle_fan()
