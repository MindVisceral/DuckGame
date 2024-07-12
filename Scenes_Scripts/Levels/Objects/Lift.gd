extends StaticBody3D




@export var monologue_data: Array[String]
## How long before the first line gets shown on screen
@export var monologue_first_line_time: float = 0.0
## The time before you can move on to the next line after a line shows up on the screen 
@export var monologue_line_time: Array[float]





@export var setpiece_script: Node

@onready var animPlayer: AnimationPlayer = $AnimationPlayer
@onready var ColliderBlock: CollisionShape3D = $ExitBlocker
var doors_closed: bool = false

func _ready() -> void:
	ColliderBlock.disabled = not doors_closed

func ride() -> void:
	## Close the doors
	if doors_closed == false:
		doors_closed = true
		animPlayer.play("close")
		ColliderBlock.disabled = false



func _on_interactable_interact() -> void:
	ride()

## Doors are closed,
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "close":
		
		if setpiece_script:
			setpiece_script.play_set_piece()
		
		## plays camera shake
		
		animPlayer.play("ride_down")


func do_screen_shake() -> void:
	Globals.camare_shake_enabled = true

func fade_to_black() -> void:
	Globals.fade_to_black = true
