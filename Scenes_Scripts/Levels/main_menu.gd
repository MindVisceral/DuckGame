extends Control


@onready var menu_margin: MarginContainer = $MarginContainer
@onready var background: ColorRect = $MarginContainer/Background

@onready var awakenSound: AudioStreamPlayer = $MarginContainer/Main_VBoxContainer/SizeLimiter_HBoxContainer/Buttons_VBoxContainer/AwakenAudioPlayer
@onready var returnSound: AudioStreamPlayer = $MarginContainer/Main_VBoxContainer/SizeLimiter_HBoxContainer/Buttons_VBoxContainer/ReturnAudioPlayer

@onready var fade_out: ColorRect = $Fade

@onready var animPlayer: AnimationPlayer = $AnimationPlayer


@onready var level: String = "res://Scenes_Scripts/Levels/level_home.tscn"

func _ready() -> void:
	if Globals.menu_color_black == true:
		background.color = Color.BLACK
	else:
		background.color = Color.WHITE

func _on_awaken_pressed() -> void:
	animPlayer.play("default")

func _on_return_pressed() -> void:
	animPlayer.play("quit")



func hide_cursor() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func next_level() -> void:
	get_tree().change_scene_to_file(level)

func quit() -> void:
	get_tree().quit()
