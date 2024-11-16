extends Node2D

func _ready():
	global.current_scene = "town"

func _process(delta):
	change_scene()

func _on_house_body_entered(body):
	if body.has_method("player"): 
		global.transition_scene = true
		global.goingIndia = false  # Ensure this is off when entering the house
		print("House entered, transition_scene =", global.transition_scene)

func _on_house_body_exited(body):
	if body.has_method("player"):
		global.transition_scene = false
		print("House exited, transition_scene =", global.transition_scene)

func _on_boat_body_enter(body):
	if body.has_method("player"): 
		global.transition_scene = true
		global.goingIndia = true
		print("Boat entered, goingIndia =", global.goingIndia)

func _on_boat_body_exited(body):
	print("Boat exited")

func change_scene():
	if global.transition_scene:
		if global.current_scene == "town" and not global.goingIndia:
			print("Changing to game.tscn")
			get_tree().change_scene_to_file("res://Scenes/game.tscn")
			global.finish_changescenes()
		elif global.current_scene == "town" and global.goingIndia:
			print("Changing to sideScroller.tscn")
			get_tree().change_scene_to_file("res://Scenes/sideScroller.tscn")
			global.finish_changescenes()
