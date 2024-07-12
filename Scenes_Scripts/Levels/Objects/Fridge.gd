extends StaticBody3D


@export var fridge_open: bool = false
@export var freezer_open: bool = false

## 
@onready var fridge_light: SpotLight3D = $FINAL_fridge_tall/Armature/Skeleton3D/Fridge_body/small_light_fridge/SpotLight3D
@onready var freezer_light: OmniLight3D = $FINAL_fridge_tall/Armature/Skeleton3D/Fridge_body/small_light_freezer/OmniLight3D
##
@onready var animPlay: AnimationPlayer = $AnimationPlayer

##
func _ready() -> void:
	fridge_light.visible = fridge_open
	freezer_light.visible = freezer_open

##
func toggle_fridge() -> void:
	if fridge_open == true:
		fridge_open = false
		animPlay.play("close_fridge")
	else:
		fridge_light.visible = true
		fridge_open = true
		animPlay.play("open_fridge")

func toggle_freezer() -> void:
	if freezer_open == true:
		freezer_open = false
		animPlay.play("close_freezer")
	else:
		freezer_light.visible = true
		freezer_open = true
		animPlay.play("open_freezer")



func _on_interactable_fridge_interact() -> void:
	toggle_fridge()


func _on_interactable_freezer_interact() -> void:
	toggle_freezer()



func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "close_fridge":
		fridge_light.visible = false
	#
	if anim_name == "close_freezer":
		freezer_light.visible = false
