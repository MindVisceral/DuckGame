extends Control


@onready var menu_margin: MarginContainer = $Main_MarginContainer
@onready var background: ColorRect = $Main_MarginContainer/Background

@onready var animPlayer: AnimationPlayer = $AnimationPlayer

@onready var previous_button: MarginContainer = $Previous_MarginContainer
@onready var next_button: MarginContainer = $Next_MarginContainer

@onready var main_menu: String = "res://Scenes_Scripts/Levels/main_menu.tscn"

func _ready() -> void:
	if Globals.menu_color_black == true:
		background.color = Color.BLACK
	else:
		background.color = Color.WHITE
	
	current_page = pages[0]
	for page in pages:
		page.visible = false
	change_page()




func _on_previous_pressed() -> void:
	animPlayer.play("previous")

func _on_return_pressed() -> void:
	animPlayer.play("return")

func _on_next_pressed() -> void:
	animPlayer.play("next")



func return_to_menu() -> void:
	get_tree().change_scene_to_file(main_menu)


@export var pages: Array[VBoxContainer] = []
var current_page_number: int = 0
var current_page: VBoxContainer

func next_page() -> void:
	if not(current_page_number + 1 >= pages.size()):
		current_page_number += 1
		
		change_page()

func previous_page() -> void:
	if not(current_page_number <= 0):
		current_page_number -= 1
		
		change_page()


func change_page() -> void:
	current_page.visible = false
	current_page = pages[current_page_number]
	current_page.visible = true
	
	if current_page_number == 0:
		previous_button.visible = false
	else:
		previous_button.visible = true
	
	if current_page_number >= pages.size() - 1:
		next_button.visible = false
	else:
		next_button.visible = true
