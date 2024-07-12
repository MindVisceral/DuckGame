extends StaticBody3D




@export var monologue_data: Array[String]
## How long before the first line gets shown on screen
@export var monologue_first_line_time: float = 0.0



@export var setpiece_script: Node

@onready var animPlayer: AnimationPlayer = $AnimationPlayer
@onready var ColliderBlock: CollisionShape3D = $ExitBlocker
@export var doors_closed: bool = false

var used: bool = false



var can_be_int: bool = false
var radio: bool = false

func _ready() -> void:
	ColliderBlock.disabled = not doors_closed
	
	if doors_closed == false:
		animPlayer.play("RESET_OPEN")
	elif doors_closed == true:
		monologue_data.clear()
		
		animPlayer.play("RESET_CLOSED")
		await animPlayer.animation_finished
		
		animPlayer.play("ride_finished")
		await animPlayer.animation_finished
		
		animPlayer.play("open")


func ride() -> void:
	if used == false:
		if doors_closed == false:
			doors_closed = true
			animPlayer.play("close")
		else:
			doors_closed = false
			animPlayer.play("open")
	
	monologue_data.clear()
	used = true



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

func fade_to_normal() -> void:
	Globals.fade_to_normal = true


@onready var level2: String = "res://Scenes_Scripts/Levels/level_outside.tscn"

func next_level() -> void:
	get_tree().change_scene_to_file(level2)
	
	Globals.camare_shake_enabled = false
	Globals.fade_to_black = false
	Globals.fade_to_white = false
	Globals.cacophony_active = false
