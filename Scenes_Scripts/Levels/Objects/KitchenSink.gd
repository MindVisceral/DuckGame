extends StaticBody3D

@onready var water: MeshInstance3D = $Water

@export var water_flowing: bool = false

func _ready() -> void:
	water.visible = water_flowing

func spill_water() -> void:
	if water_flowing == true:
		water_flowing = false
		water.visible = false
	else:
		water_flowing = true
		water.visible = true


func _on_interactable_interact() -> void:
	spill_water()
