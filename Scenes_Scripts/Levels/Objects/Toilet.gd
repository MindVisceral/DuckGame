extends StaticBody3D


@onready var topAP: AnimationPlayer = $TopAP
@onready var botAP: AnimationPlayer = $BotAP
@onready var flushAP: AnimationPlayer = $FlushAP

@export var top_open: bool = false
@export var bot_open: bool = false


func _ready() -> void:
	if top_open == true:
		top_flip()
		
		if bot_open == true:
			bot_flip()


func flush() -> void:
	flushAP.play("flush")

func top_flip() -> void:
	if top_open == true:
		top_open = false
		topAP.play("top_close")
	else:
		top_open = true
		topAP.play("top_open")

func bot_flip() -> void:
	if bot_open == true:
		bot_open = false
		botAP.play("bot_close")
	else:
		bot_open = true
		if top_open == false:
			top_flip()
		botAP.play("bot_open")



func _on_flush_interactable_interact() -> void:
	flush()


func _on_top_interactable_interact() -> void:
	top_flip()
	print("TOP")


func _on_bot_interactable_interact() -> void:
	bot_flip()
	print("BOT")
