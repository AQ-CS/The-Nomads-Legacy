extends Node2D

func _ready():
	global2.leavingMorocco = true
	
func _process(delta):
	change_scene()

func _on_house_body_entered(body):
	global2.goingShip = false
	if body.has_method("player"): 
		global2.goingHouse = true
		

func _on_boat_body_enter(body):
	print("boat entered")
	global2.goingHouse = false
	if body.has_method("player"): 
		global2.goingShip = true


func change_scene():
	if global2.goingHouse == true:
		print("going house")
		get_tree().change_scene_to_file("res://Scenes/Areas/game.tscn")
		global2.changeBack()
	elif global2.goingShip == true:
		print("going ship")
		get_tree().change_scene_to_file("res://sceness/ship_game.tscn")
		global2.changeBack()
