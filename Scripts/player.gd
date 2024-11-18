extends CharacterBody2D

const SPEED = 300
var current_dir = "none"

var clicks = 0

@onready var actionable_finder: Area2D = $Direction/ActionableFinder
func _ready():
	$AnimatedSprite2D.play("Idle")

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel") && clicks == 0:
		clicks += 1
		print(clicks)
	elif Input.is_action_just_pressed("ui_cancel") && clicks == 1:
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
	if clicks == 0:
		if Input.is_action_pressed("ui_right"):
			current_dir = "right"
			velocity.x = SPEED
			velocity.y = 0
			play_anim(1)
		elif Input.is_action_pressed("ui_left"):
			current_dir = "left"
			velocity.x = -SPEED
			velocity.y = 0
			play_anim(1)
		elif Input.is_action_pressed("ui_down"):
			current_dir = "down"
			velocity.x = 0
			velocity.y = SPEED
			play_anim(1)
		elif Input.is_action_pressed("ui_up"):
			current_dir = "up"
			velocity.x = 0
			velocity.y = -SPEED
			play_anim(1)
		else:
			velocity = Vector2.ZERO
			play_anim(0)

		move_and_slide()

func play_anim(movement):
	var anim = $AnimatedSprite2D
	
	match current_dir:
		"right":
			anim.flip_h = false
			anim.play("Right" if movement == 1 else "Idle")
		"left":
			anim.flip_h = true
			anim.play("Right" if movement == 1 else "Idle")
		"down":
			anim.flip_h = false
			anim.play("Down" if movement == 1 else "Idle")
		"up":
			anim.flip_h = false
			anim.play("Up" if movement == 1 else "Idle")

func player():
	pass
