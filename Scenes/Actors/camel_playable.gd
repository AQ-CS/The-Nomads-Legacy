extends Area2D

@onready var player = $"../Player"  # Reference to the player node

func _ready():
	$Label.hide()  # Hide the prompt by default
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body):
	if body.name == "Player":
		$Label.show()

func _on_body_exited(body):
	if body.name == "Player":
		$Label.hide()

func _process(delta):
	if Input.is_action_just_pressed("ui_mount") and $Label.visible:
		State.riding_camel = true
		global_position = player.global_position  # Match camel's position to the player's position
		self.hide()  # Hide the Area2D to simulate mounting
		$Label.hide()
