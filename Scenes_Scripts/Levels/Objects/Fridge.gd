extends StaticBody3D




## Contains Strings, which are taken by the MonologueUI Node, which displays them in the
## Player's monologue box
@export var monologue_data: Array[String]
## How long before the first line gets shown on screen
@export var monologue_first_line_time: float = 0.0





@export var fridge_open: bool = false
@export var freezer_open: bool = false

## 
@onready var fridge_light: SpotLight3D = $FINAL_fridge_tall/Armature/Skeleton3D/Fridge_body/small_light_fridge/SpotLight3D
@onready var freezer_light: OmniLight3D = $FINAL_fridge_tall/Armature/Skeleton3D/Fridge_body/small_light_freezer/OmniLight3D
##
@onready var FridgeanimPlay: AnimationPlayer = $FridgeAnimationPlayer
@onready var FreezeranimPlay: AnimationPlayer =$FreezerAnimationPlayer




var is_focused: bool = false
@export var focused_meshes: Array[MeshInstance3D]


var can_be_int: bool = false


##
func _ready() -> void:
	fridge_light.visible = fridge_open
	freezer_light.visible = freezer_open




##
func toggle_fridge() -> void:
	if !FridgeanimPlay.is_playing():
		if fridge_open == true:
			fridge_open = false
			FridgeanimPlay.play("close_fridge")
		else:
			fridge_light.visible = true
			fridge_open = true
			FridgeanimPlay.play("open_fridge")

func toggle_freezer() -> void:
	if !FreezeranimPlay.is_playing():
		if freezer_open == true:
			freezer_open = false
			FreezeranimPlay.play("close_freezer")
		else:
			freezer_light.visible = true
			freezer_open = true
			FreezeranimPlay.play("open_freezer")



func _on_interactable_fridge_interact() -> void:
	toggle_fridge()


func _on_interactable_freezer_interact() -> void:
	toggle_freezer()



func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "close_fridge":
		fridge_light.visible = false


func _on_freezer_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "close_freezer":
		freezer_light.visible = false
