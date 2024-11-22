extends Node2D

@onready var player = $Player

func _ready() -> void:
	
	player.position.x = State.playerX 
	player.position.y = State.playerY + 50
	global2.visitedIndia = true
	
func _process(delta):
	change_scene()
	
func save_player_position():
	State.playerX = player.position.x
	State.playerY = player.position.y

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
		save_player_position()
		get_tree().change_scene_to_file("res://Scenes/Areas/Sultan.tscn")
		global2.changeBack()
		print("Saved Position: ", State.playerX)
		print("Saved Position: ", State.playerY)
		
	elif global2.goingMin1 == true:
		save_player_position()
		get_tree().change_scene_to_file("res://Scenes/Areas/Min1.tscn")
		global2.changeBack()
		
	elif global2.goingMin2 == true:
		save_player_position()
		get_tree().change_scene_to_file("res://Scenes/Areas/Min2.tscn")
		global2.changeBack()
		
	elif global2.goingMorocco == true:
		save_player_position()
		get_tree().change_scene_to_file("res://Scenes/Areas/town.tscn")
		global2.changeBack()
		
	elif global2.goingIndiaSide == true:
		save_player_position()
		get_tree().change_scene_to_file("res://sceness/world.tscn")
		global2.changeBack()
