extends Node

var mouse_sensitivity = 0.08
var joypad_sensitivity = 2

var global_gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")


var camare_shake_enabled: bool = false
var fade_to_black: bool = false
var fade_to_white: bool = false

var cacophony_active: bool = false
