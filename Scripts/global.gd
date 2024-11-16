extends Node

var player_current_attack = false
var goingIndia = false
var current_scene = "world"
var transition_scene = false
var game_first_loadin = true

func finish_changescenes():
	# Reset the transition flag
	transition_scene = false

	# Update the current scene based on the previous one and the context
	if current_scene == "world":
		current_scene = "town"
	elif current_scene == "town":
		if goingIndia:
			current_scene = "sideScroller"
		else:
			current_scene = "world"

	print("Scene transition complete. Current scene =", current_scene)
