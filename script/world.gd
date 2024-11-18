extends Node2D

var transition_audio_played = false  # Flag to track if the audio has played

func _ready():
	$music.play()
	global.current_scene = "world"
	global.transition_to_ambush = false
	transition_audio_played = false  # Reset flag at the start

	if global.game_first_loadin:
		$player.position.x = global.player_start_posx
		$player.position.y = global.player_start_posy
	else:
		$player.position.x = global.player_exit_cliffside_posx
		$player.position.y = global.player_exit_cliffside_posy
		
func reset_game():
	get_tree().reload_current_scene()

func _process(delta):
	change_scene()
	
	if global.player_alive == false:
		$music.stop()
		await get_tree().create_timer(5).timeout
		global.player_alive = true
		reset_game()

func _on_cliffside_transition_point_body_entered(body):
	if body.has_method("player"):
		global.transition_scene = true

func _on_cliffside_transition_point_body_exited(body):
	if body.has_method("player"):
		global.transition_scene = false

func _on_ambush_transition_point_body_entered(body):
	if body.has_method("player"):
		global.transition_to_ambush = true

func _on_ambush_transition_point_body_exited(body):
	if body.has_method("player"):
		global.transition_to_ambush = false
		
func change_scene():
	if global.transition_scene == true and not transition_audio_played:
		$music.stop()
		$transition_audio.play()
		transition_audio_played = true
		await get_tree().create_timer(1.2).timeout
		if global.current_scene == "world":
			get_tree().change_scene_to_file("res://sceness/cliff_side.tscn")
			global.game_first_loadin = false
			global.finish_changescenes()
			transition_audio_played = false
	elif global.transition_to_ambush == true and not transition_audio_played:
		$music.stop()
		$transition_audio.play()
		transition_audio_played = true
		await get_tree().create_timer(1.2).timeout
		get_tree().change_scene_to_file("res://sceness/ambush.tscn")
		global.finish_changescenes()
		transition_audio_played = false
