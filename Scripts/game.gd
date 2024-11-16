extends Node2D

func _ready():
	global.current_scene = "world"
	
	
func _process(delta):
	change_scene()


func _on_body_entered(body):
	if body.has_method("player"): 
		global.transition_scene = true
		print(global.transition_scene)


func _on_body_exited(body):
	if body.has_method("player"):
		global.transition_scene = false
		
func change_scene():
	if global.transition_scene == true:
		print(global.transition_scene)
		if global.current_scene == "town":
			get_tree().change_scene_to_file("res://scenes/town.tscn")
			global.finish_changescenes()
