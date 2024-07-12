class_name PlayerInteractionManager
extends Node


###-------------------------------------------------------------------------###
##### Variables and references
###-------------------------------------------------------------------------###

## Reference to the Player, so its functions and variables can be accessed directly
var player: Player

## All the Interactable nodes within Player's reach (reach is set in each Interactable separately)
var interactables: Array[Interactable] = []

@onready var interact_HUD: MarginContainer = $"../../Head/BobbingNode/PlayerCamera/HUD/EMarginContainer"
@onready var think_HUD: MarginContainer = $"../../Head/BobbingNode/PlayerCamera/HUD/FMarginContainer2"

###-------------------------------------------------------------------------###
##### Setup functions
###-------------------------------------------------------------------------###

## This Node needs a reference to the Player to access its functions and variables
func init(player: Player) -> void:
	self.player = player
	
	interact_HUD.visible = false
	think_HUD.visible = false

###-------------------------------------------------------------------------###
##### Executing functions
###-------------------------------------------------------------------------###

func _physics_process(delta: float) -> void:
	
#region No Interactables in range
	## If there are no Interactables within range, we turn off the InteractableCast for efficiency
	if interactables.size() == 0:
		interact_HUD.visible = false
		think_HUD.visible = false
		player.InteractableCast.enabled = false
#endregion
	
#region One Interactable within range
	## Otherwise, we turn it on and...
	elif interactables.size() == 1:
		interact_HUD.visible = false
		think_HUD.visible = false
		
		for interactable in interactables:
			interactable.unfocused.emit()
		
		
		player.InteractableCast.enabled = true
		
		## ...check if the InteractableCast intersects with that one Interactable
		player.InteractableCast.force_shapecast_update()
		if player.InteractableCast.is_colliding():
			
			## Since it does, we tell this Interactable to emit the "focused" signal
			interactables[0].focused.emit()
			
			
			if "monologue_data" in interactables[0].owner:
				if not interactables[0].owner.monologue_data.is_empty():
					think_HUD.visible = true
			if "can_be_int" in interactables[0].owner:
				interact_HUD.visible = true
				if "is_locked" in interactables[0].owner:
					if interactables[0].owner.is_locked == true:
						interact_HUD.visible = false 
					else:
						interact_HUD.visible = true
			
			
			
			## If the Player wants to, they may interact with this Interactable
			if Input.is_action_just_pressed("input_interact"):
				#player.InteractableCast.get_collider(0).interact.emit()
				interactables[0].interact.emit()
			if Input.is_action_just_pressed("input_thoughts"):
				#get_interactable_monologue_info(player.InteractableCast.get_collider(0))
				get_interactable_monologue_info(interactables[0])
			
		
		## Since it doesn't, we tell this Interactable to emit the "unfocused" signal
		else:
			for interactable in interactables:
				interactable.unfocused.emit()
			## The Interactable becomes "unfocused" if the Player exits its range too
			## (that is written into the Interactable code itself)
#endregion
	
#region Two or more Interactables are within range
	## Here, we also turn on the InteractableCast and...
	elif interactables.size() >= 2:
		interact_HUD.visible = false
		think_HUD.visible = false
		
		for interactable in interactables:
			interactable.unfocused.emit()
		
		
		player.InteractableCast.enabled = true
		## ...check if the InteractableCast intersects with at least one of those Interactables
		player.InteractableCast.force_shapecast_update()
		if player.InteractableCast.is_colliding():
			
			## Since there is more than one Interactable within range,
			## we check which one that is the closest to the Player...
			var closest_interactable = find_closest_interactable()
			## ...unfocus all of them...
			for interactable in interactables:
				interactable.unfocused.emit()
			## ...and finally, focus only on the closest Interactable
			closest_interactable.focused.emit()
			
			
			if "monologue_data" in closest_interactable.owner:
				if closest_interactable.owner.monologue_data.is_empty() == false:
					think_HUD.visible = true
			if "can_be_int" in closest_interactable.owner:
				interact_HUD.visible = true
				if "is_locked" in closest_interactable.owner:
					if closest_interactable.owner.is_locked == true:
						interact_HUD.visible = false
					else:
						interact_HUD.visible = true
			
			
			## And if the Player wants to, they may interact with this Interactable
			if Input.is_action_just_pressed("input_interact"):
				closest_interactable.interact.emit()
			if Input.is_action_just_pressed("input_thoughts"):
				get_interactable_monologue_info(closest_interactable)
			
		
		## If it isn't colliding, we unfocus all the Interactables
		else:
			for interactable in interactables:
				interactable.unfocused.emit()
			## An Interactables becomes "unfocused" if the Player exits its range too
			## (that is written into the Interactable code itself)
#endregion


## Finds the Interactable which is the nearest to the Player
## (but only if it has been detected by InteractableCast)
func find_closest_interactable() -> Interactable:
	
	## INF on our first check in the loop, because there is no bigger distance than that
	var distance_to_interactable = INF
	## I left this at Null, because we know that there is a closest Interactable somewhere
	## If we couldn't be absolutely sure of that, as we are here, this would have to be different
	var closest_interactable: Interactable
	
	## We loop through all the results in InteractableCast's collision_result
	## to find the collider (Interactable) that is the closest to the Player
	for result in player.InteractableCast.collision_result:
		## We get this Interactable's distance to the Player...
		var new_distance = result.collider.global_position.distance_to(player.global_position)
		## ...and check if this distance is smaller than the last distance...
		if new_distance < distance_to_interactable:
			## If so, we update these two variables
			distance_to_interactable = new_distance
			closest_interactable = result.collider
		
	
	## Now that we are sure which Interactable is the closest, we simply return it
	return closest_interactable


func get_interactable_monologue_info(interactable) -> void:
	
	## We only send new data if the Monologue is done with all the lines
	if player.Monologue.accept_new_data == true:
		
		var data: Array
		var first_time: float
		var data_time: Array
		if "monologue_data" in interactable.owner:
			data = interactable.owner.monologue_data.duplicate()
		if "monologue_first_line_time" in interactable.owner:
			first_time = interactable.owner.monologue_first_line_time
		if "monologue_line_time" in interactable.owner:
			data_time = interactable.owner.monologue_line_time.duplicate()
		
		if data != null:
			if data.is_empty():
				print("empty")
				player.Monologue.reset_monologue()
			else:
				player.Monologue.reset_monologue()
				
				player.Monologue.monologue = data
				player.Monologue.first_line_time = first_time
				player.Monologue.monologue_time = data_time
				
				player.Monologue.start_monologue()
