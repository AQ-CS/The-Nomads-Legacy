extends Area2D

func _ready():
	$Label.hide()  # Hide the prompt by default
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body):
	print("Entered apple")
	if body.name == "Player":
		$Label.text = "[E] to Interact"
		$Label.show()

func _on_body_exited(body):
	if body.name == "Player":
		$Label.hide()
		
func _process(delta):
	if Input.is_action_just_pressed("ui_accept") and $Label.visible:
		State.apple_status = "has"  # Access the singleton instance
		self.hide()  # Hide the Area2D
		$Label.hide()  # Hide the label
		print("apple_Status is now:", State.apple_status)  # Debug print
