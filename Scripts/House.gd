extends Node2D
	
func _process(delta):
	change_scene()


func _on_body_entered(body):
	if body.has_method("player"): 
		global2.goingTown = true
		
func change_scene():
	if global2.goingTown == true:
		get_tree().change_scene_to_file("res://scenes/Areas/town.tscn")
		global2.changeBack()
