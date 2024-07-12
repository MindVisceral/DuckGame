extends Node





@onready var blackanim: AnimationPlayer = $"../../Head/BobbingNode/PlayerCamera/CutsceneEffects/SubViewportContainer/SubViewport/CanvasLayer/BlackAnimationPlayer"
@onready var whiteanim: AnimationPlayer = $"../../Head/BobbingNode/PlayerCamera/CutsceneEffects/SubViewportContainer/SubViewport/CanvasLayer/WhiteAnimationPlayer"


var player: Player

## This Node needs a reference to the Player to access its functions and variables
func init(player: Player) -> void:
	self.player = player
	
	blackanim.play("fade_out")
	await blackanim.animation_finished
	blackanim.play("blank")


func _process(delta: float) -> void:
	## Fade to black when a cutscene demands it.
	if Globals.fade_to_black == true:
		Globals.fade_to_black = false
		blackanim.play("fade_in")
	
	if Globals.fade_to_white == true:
		Globals.fade_to_white = false
		whiteanim.play("fade_in")
	
	if Globals.fade_to_normal == true:
		Globals.fade_to_normal = false
		blackanim.play("fade_out")
		
		whiteanim.play("fade_out")
