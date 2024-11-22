extends CharacterBody2D

const BASE_SPEED = 300
const CAMEL_SPEED = 500
var current_dir = "none"

var clicks = 0

@onready var actionable_finder: Area2D = $Direction/ActionableFinder
@onready var camel = $"../camel"  # Reference to the camel node

func _ready():
	$AnimatedSprite2D.play("Idle")

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_mount"):
		if State.riding_camel:
			State.riding_camel = false
			camel.global_position = global_position  # Place the scamel at the player's position
			camel.show()  # Make the camel visible again
	
	if Input.is_action_just_pressed("ui_cancel") and clicks == 0:
		clicks += 1
		print(clicks)
	elif Input.is_action_just_pressed("ui_cancel") and clicks == 1:
		clicks = 0
		
	if Input.is_action_just_pressed("ui_accept"):
		var actionables = actionable_finder.get_overlapping_areas()
		if actionables.size() > 0:
			actionables[0].action()
			return

func _physics_process(delta):
	if State.in_dialogue == true:
		var anim = $AnimatedSprite2D
		anim.play("Idle")
		return
	player_movement(delta)

func player_movement(delta):
	var speed = CAMEL_SPEED if State.riding_camel else BASE_SPEED  # Adjust speed based on camel state

	if clicks == 0:
		if Input.is_action_pressed("ui_right"):
			current_dir = "right"
			velocity.x = speed
			velocity.y = 0
			play_anim(1)
		elif Input.is_action_pressed("ui_left"):
			current_dir = "left"
			velocity.x = -speed
			velocity.y = 0
			play_anim(1)
		elif Input.is_action_pressed("ui_down"):
			current_dir = "down"
			velocity.x = 0
			velocity.y = speed
			play_anim(1)
		elif Input.is_action_pressed("ui_up"):
			current_dir = "up"
			velocity.x = 0
			velocity.y = -speed
			play_anim(1)
		else:
			velocity = Vector2.ZERO
			play_anim(0)

		move_and_slide()

func play_anim(movement):
	var sprite = $CamelSprite if State.riding_camel else $AnimatedSprite2D
	var other_sprite = $AnimatedSprite2D if State.riding_camel else $CamelSprite
	sprite.visible = true
	other_sprite.visible = false
	match current_dir:
		"right":
			sprite.flip_h = false
			sprite.play("Right" if movement == 1 else "Idle")
		"left":
			sprite.flip_h = true
			sprite.play("Right" if movement == 1 else "Idle")
		"down":
			sprite.flip_h = false
			sprite.play("Down" if movement == 1 else "Idle")
		"up":
			sprite.flip_h = false
			sprite.play("Up" if movement == 1 else "Idle")

func player():
	pass
