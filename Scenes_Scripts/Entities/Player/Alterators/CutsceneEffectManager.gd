extends Node

var player: Player

## This Node needs a reference to the Player to access its functions and variables
func init(player: Player) -> void:
	self.player = player


func _process(delta: float) -> void:
	## Fade to black when a cutscene demands it.
	if Globals.fade_to_black == true:
		#var tween = get_tree().create_tween()
		#var new_color: Color = Color(player.FadeToBlack.color, 255)
		#tween.tween_property(player.FadeToBlack, "color", new_color, 0.01 * delta)
		
		player.FadeToBlack.color.a = lerpf(player.FadeToBlack.color.a, 255, 0.001 * delta)