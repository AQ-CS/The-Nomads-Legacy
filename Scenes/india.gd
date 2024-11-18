extends Node2D

func _ready() -> void:
	global2.visitedIndia = true
	
func _process(delta):
	change_scene()

func _on_sultan_body_entered(body):
	if body.has_method("player"): 
		global2.goingSultan = true

func _on_minister1_body_entered(body):
	if body.has_method("player"): 
		global2.goingMin1 = true

func _on_minister2_body_entered(body):
	if body.has_method("player"): 
		global2.goingMin2 = true

func _on_return_body_entered(body):
	if body.has_method("player"): 
		global2.goingMorocco = true
		
func _on_side_body_entered(body):
	if body.has_method("player"): 
		global2.goingIndiaSide = true

func change_scene():
	if global2.goingSultan == true:
		print("Going Sultan")
		get_tree().change_scene_to_file("res://Scenes/Areas/Sultan.tscn")
		global2.changeBack()
		
	elif global2.goingMin1 == true:
		get_tree().change_scene_to_file("res://Scenes/Areas/Min1.tscn")
		global2.changeBack()
		
	elif global2.goingMin2 == true:
		get_tree().change_scene_to_file("res://Scenes/Areas/Min2.tscn")
		global2.changeBack()
		
	elif global2.goingMorocco == true:
		get_tree().change_scene_to_file("res://Scenes/Areas/town.tscn")
		global2.changeBack()
		
	elif global2.goingIndiaSide == true:
		get_tree().change_scene_to_file("res://sceness/world.tscn")
		global2.changeBack()
