extends CharacterBody2D

# Export variables for adjustable speed
@export var speed: float = 200.0  # Speed to the right
@export var upspeed: float = 100.0  # Speed for moving up/down

var has_camel_hit = false

func _ready():
	# Set initial velocity
	velocity.x = speed
	# Connect the signal with the correct Callable
	$AnimatedSprite2D.animation_finished.connect(_on_animation_finished)

func _process(delta):
	# Move the ship up/down
	if global.ship_crash == false:
		$AnimatedSprite2D.play("move")
		if Input.is_action_pressed("ui_up"):
			velocity.y = -upspeed
		elif Input.is_action_pressed("ui_down"):
			velocity.y = upspeed
		else:
			velocity.y = 0
	else:
		if not has_camel_hit:
			$AnimatedSprite2D.play("camel_down")
			has_camel_hit = true
		return

	# Apply the velocity to the ship's movement
	move_and_slide()

func _on_animation_finished():
	# Handle what happens after the wreck animation finishes
	if $AnimatedSprite2D.animation == "camel_down":
		$AnimatedSprite2D.stop() # Stop the animation or take other actions if needed
		
func ship():
	pass
