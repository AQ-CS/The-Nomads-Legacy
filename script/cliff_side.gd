extends Node2D

var transition_audio_played = false

func _ready():
	$music.play()
	global.current_scene = "cliff_side"
	transition_audio_played = false

func _process(delta):
	change_scene()
	
	if global.player_alive == false:
		$music.stop()
		await get_tree().create_timer(5).timeout
		global.player_alive = true
		global.game_first_loadin = true
		get_tree().change_scene_to_file("res://sceness/world.tscn")
		global.finish_changescenes()

func _on_cliffside_exitpoint_body_entered(body):
	if body.has_method("player"): 
		global.transition_scene = true

func _on_cliffside_exitpoint_body_exited(body):
	if body.has_method("player"):
		global.transition_scene = false

func change_scene():
	if global.transition_scene == true and not transition_audio_played:
		if global.current_scene == "cliff_side":
			$music.stop()
			$transition_audio.play()
			transition_audio_played = true  
			await get_tree().create_timer(0.8).timeout
			global.game_first_loadin = false
			global.player_exit_cliffside_posx = 474
			global.player_exit_cliffside_posy = 28
			get_tree().change_scene_to_file("res://sceness/world.tscn")
			global.finish_changescenes()
