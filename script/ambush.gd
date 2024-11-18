extends Node2D

var transition_audio_played = false  # Flag to track if the audio has played

func _ready():
	$music.play()
	global.current_scene = "ambush"
	transition_audio_played = false  # Reset the flag when the scene is loaded

func _process(delta):
	change_scene()
	if global.player_alive == false:
		$music.stop()
		await get_tree().create_timer(5).timeout
		global.player_alive = true
		global.game_first_loadin = true
		get_tree().change_scene_to_file("res://sceness/world.tscn")
		global.finish_changescenes()

func _on_ambush_exitpoint_body_entered(body):
	if body.has_method("player"): 
		global.transition_scene = true

func _on_ambush_exitpoint_body_exited(body):
	if body.has_method("player"):
		global.transition_scene = false

func change_scene():
	if global.transition_scene == true and not transition_audio_played:
		$music.stop()
		$transition_audio.play()
		transition_audio_played = true  # Ensure the audio plays only once
		await get_tree().create_timer(0.8).timeout
		global.game_first_loadin = false
		global.player_exit_cliffside_posx = 343
		global.player_exit_cliffside_posy = 272
		get_tree().change_scene_to_file("res://sceness/world.tscn")
		global.finish_changescenes()
		transition_audio_played = false  # Reset the flag after the transition
