extends Area2D

var is_player_near = false  # Tracks if the player is in the area
var dialogue_active = false  # Tracks if dialogue is currently happening
var dialogue_lines = []  # Holds NPC's dialogue lines
var current_line_index = 0  # Tracks the current line of dialogue

func _ready():
	$Label.hide()  # Hide the prompt by default
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body):
	# Check if the player entered the area
	if body.name == "Player":
		is_player_near = true
		if not dialogue_active:
			$Label.show()

func _on_body_exited(body):
	# Hide the prompt when the player leaves
	if body.name == "Player":
		is_player_near = false
		$Label.hide()

func _process(delta):
	# Listen for the "E" key while the player is near
	if is_player_near and Input.is_action_just_pressed("ui_accept"):  # "ui_accept" is usually mapped to "E"
		$Label.hide()
		
		
		
