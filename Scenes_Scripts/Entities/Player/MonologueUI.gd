extends Control

@onready var background: Panel = $AspectRatioContainer/MarginContainer/TextBackground_Panel
@onready var textbox: RichTextLabel = $AspectRatioContainer/MarginContainer/TextBackground_Panel/Monologue_RichTextLabel
@onready var sprite_anim: AnimationPlayer = $AspectRatioContainer/MarginContainer/TextBackground_Panel/Continue_MarginContainer/Arrow_Sprite2D/AnimationPlayer
@onready var timer: Timer = $AspectRatioContainer/MarginContainer/TextBackground_Panel/DialogTimer
@onready var beep_audioplayer: AudioStreamPlayer = $BeepAudioPlayer
@onready var newlinebeep_audioplayer: AudioStreamPlayer = $linebeepAudioPlayer
@onready var lastlinebeep_audioplayer: AudioStreamPlayer = $lastbeepAudioPlayer

## Holds all the lines in the monologue that comes from interacting with this specific
## Interactable. These lines are set in the Interactable itself.
var monologue: Array
var current_monologue_line: int = 0
## Time before the first line is shown
var first_line_time: float = 0
## Time before the next line is shown
var monologue_time: Array = []

## We only make new monologue show up when the current monologue is over
var accept_new_data: bool = true

## If false, the line sounds may no longer play
var lines_can_play: bool = false

func _ready() -> void:
	reset_monologue()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		if timer.is_stopped():
			nextPhrase()


## The dialogue has started,
func start_monologue():
	accept_new_data = false
	
	
	## We wait a moment to make the textbox shows up, if it isn't set to show up immediately
	if first_line_time > 0.0:
		await get_tree().create_timer(first_line_time).timeout
	
	if !monologue.is_empty():
		if not (current_monologue_line >= monologue_time.size()):
			timer.wait_time = monologue_time[current_monologue_line]
		else:
			timer.wait_time = 0.001
		timer.start()
		
		lines_can_play = true
		background.visible = true
		beep_audioplayer.play()
		textbox.text = monologue[current_monologue_line]
		current_monologue_line += 1
	else:
		reset_monologue()

func nextPhrase() -> void:
	if current_monologue_line >= monologue_time.size():
		timer.wait_time = 0.001
	else:
		timer.wait_time = monologue_time[current_monologue_line]
	#
	timer.start()
	
	sprite_anim.play("invisible")
	
	
	## When we reach the end of the monologue, we reset the whole thing
	if current_monologue_line >= monologue.size():
		reset_monologue()
	## Othwerwise, we set the next monologue line in the Array
	else:
		textbox.text = monologue[current_monologue_line]
		if lines_can_play == true:
			newlinebeep_audioplayer.play()
	
	if current_monologue_line == monologue.size():
		if lines_can_play == true:
			lastlinebeep_audioplayer.play()
			lines_can_play = false
	
	current_monologue_line += 1

## We reset everything
func reset_monologue() -> void:
	current_monologue_line = 0
	monologue.clear()
	background.visible = false
	timer.stop()
	sprite_anim.play("invisible")
	textbox.text = ""
	accept_new_data = true

## Time to read the text is over, we may proceed now
func _on_dialog_timer_timeout() -> void:
	sprite_anim.play("move")
