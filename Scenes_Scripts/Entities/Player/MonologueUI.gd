extends Control

@onready var textbox: RichTextLabel = $AspectRatioContainer/MarginContainer/TextBackground_Panel/Monologue_RichTextLabel
@onready var sprite_anim: AnimationPlayer = $AspectRatioContainer/MarginContainer/TextBackground_Panel/Continue_MarginContainer/Arrow_Sprite2D/AnimationPlayer
@onready var timer: Timer = $AspectRatioContainer/MarginContainer/TextBackground_Panel/DialogTimer
@onready var beep_audioplayer: AudioStreamPlayer = $BeepAudioPlayer

## Holds all the lines in the monologue that comes from interacting with this specific
## Interactable. These lines are set in the Interactable itself.
var monologue: Array
var current_array_postion: int = 0

func _ready() -> void:
	sprite_anim.play("invisible")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		if timer.is_stopped():
			nextPhrase()


## The dialogue has started,
func start_monologue():
	print("started")
	
	## We start up the Timer so that the Player can't just button mash through dialogue
	timer.start()
	
	if !monologue.is_empty():
		beep_audioplayer.play()
		textbox.text = monologue[current_array_postion]
		current_array_postion += 1
	else:
		reset_monologue()

func nextPhrase() -> void:
	timer.start()
	sprite_anim.play("invisible")
	
	## When we reach the end of the monologue, we reset the whole thing
	if current_array_postion >= monologue.size():
		reset_monologue()
	## Othwerwise, we set the next monologue line in the Array
	else:
		textbox.text = monologue[current_array_postion]
	
	current_array_postion += 1

## We reset everything
func reset_monologue() -> void:
	current_array_postion = 0
	monologue.clear()
	
	
	timer.stop()
	sprite_anim.play("invisible")
	textbox.text = ""

## Time to read the text is over, we may proceed now
func _on_dialog_timer_timeout() -> void:
	sprite_anim.play("move")
