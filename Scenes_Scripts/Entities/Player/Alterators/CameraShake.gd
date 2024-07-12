extends Node

@export var randomStrength: float = 30.0
@export var shakeFade: float = 5.0

var rng = RandomNumberGenerator.new()

var shake_strength: float = 0.0

var player: Player

## This Node needs a reference to the Player to access its functions and variables
func init(player: Player) -> void:
	self.player = player



func apply_shake() -> void:
	shake_strength = randomStrength

func randomOffset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strength, shake_strength), \
					rng.randf_range(-shake_strength, shake_strength))

func _process(delta: float) -> void:
	if Globals.camare_shake_enabled == true:
		apply_shake()
		Globals.camare_shake_enabled = false
	
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0, shakeFade * delta)
		
		player.Camera.h_offset = randomOffset().x
		player.Camera.v_offset = randomOffset().y
	
	
	
