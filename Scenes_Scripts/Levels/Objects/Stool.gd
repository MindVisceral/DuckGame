extends StaticBody3D


## Contains Strings, which are taken by the MonologueUI Node, which displays them in the
## Player's monologue box
@export var monologue_data: Array[String]
## How long before the first line gets shown on screen
@export var monologue_first_line_time: float = 0.0

var is_focused: bool = false
@export var focused_meshes: Array[MeshInstance3D]


func _on_interactable_interact() -> void:
	pass


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
