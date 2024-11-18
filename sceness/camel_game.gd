extends Node2D

var crash_audio_played = false  # Flag to track if the crash audio has been played
var transitioning = false  # Flag to prevent simultaneous transitions

# Called when the node enters the scene tree for the first time.
func _ready():
	$music.play()
	global.ship_crash = false  # Reset the crash status
	crash_audio_played = false  # Reset the audio flag
	global2.visitedMecca = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global.ship_crash == true and not crash_audio_played and not transitioning:
		transitioning = true  # Block other transitions
		$music.stop()
		$crash.play()
		crash_audio_played = true  # Ensure the crash audio plays only once
		await get_tree().create_timer(5).timeout
		global.ship_crash = false
		restart_scene()

func restart_scene():
	# Restart the current scene
	get_tree().change_scene_to_file("res://sceness/camel_game.tscn")
	transitioning = false  # Reset the flag after transitioning

func _on_body_entered(body):
	global2.goingIndia = true
	if global2.goingIndia == true:
		get_tree().change_scene_to_file("res://Scenes/Areas/india.tscn")
		global2.changeBack()
