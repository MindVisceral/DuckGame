extends StaticBody3D

@onready var light: OmniLight3D = $OmniLight3D

var turned_on: bool = false

func _ready() -> void:
	light.visible = turned_on


func toggle_light() -> void:
	if turned_on == true:
		turned_on = false
	else:
		turned_on = true
	
	light.visible = turned_on


func interact() -> void:
	toggle_light()
