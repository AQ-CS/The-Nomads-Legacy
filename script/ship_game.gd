extends Node2D

var crash_audio_played = false  # Flag to track if the crash audio has been played

# Called when the node enters the scene tree for the first time.
func _ready():
	$music.play()
	global.ship_crash = false
	crash_audio_played = false  # Reset the flag when the scene starts

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global.ship_crash == true and not crash_audio_played:
		$music.stop()
		$crash.play()
		crash_audio_played = true  # Ensure the crash audio plays only once
		await get_tree().create_timer(5).timeout
		global.ship_crash = false
		restart_scene()

func restart_scene():
	# Restart the current scene
	get_tree().change_scene_to_file("res://sceness/ship_game.tscn")


func _on_win_body_entered(body):
	global2.goingCamel = true
	if body.has_method("ship"):
		if global2.goingCamel == true:
			get_tree().change_scene_to_file("res://sceness/camel_game.tscn")
			global2.changeBack()
		
	
