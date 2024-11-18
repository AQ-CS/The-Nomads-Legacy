extends Node2D
	
func _process(delta):
	change_scene()


func _on_body_entered(body):
	if body.has_method("player"): 
		global2.goingIndia = true
		
func change_scene():
	if global2.goingIndia == true:
		get_tree().change_scene_to_file("res://Scenes/Areas/india.tscn")
		global2.changeBack()
