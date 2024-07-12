extends Control


@onready var menu_margin: MarginContainer = $MarginContainer
@onready var background: ColorRect = $MarginContainer/Background

@onready var returnSound: AudioStreamPlayer = $MarginContainer/Main_VBoxContainer/SizeLimiter_HBoxContainer/Buttons_VBoxContainer/ReturnAudioPlayer

@onready var animPlayer: AnimationPlayer = $AnimationPlayer


@onready var main_menu: String = "res://Scenes_Scripts/Levels/main_menu.tscn"

func _ready() -> void:
	if Globals.menu_color_black == true:
		background.color = Color.BLACK
	else:
		background.color = Color.WHITE



func _on_return_pressed() -> void:
	animPlayer.play("return")


func return_to_menu() -> void:
	get_tree().change_scene_to_file(main_menu)
