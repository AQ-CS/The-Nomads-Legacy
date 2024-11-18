extends CharacterBody2D

const SPEED = 100
var current_dir = "none"

var enemy_inattack_range = false
var enemy_attack_cooldown = true
var health = 100
var player_alive = true
var death_animation_played = false
var death_audio_played = false 
var can_play_sword_audio = true


var attack_ip = false

func _ready():
	$AnimatedSprite2D.play("front_idle")
	death_audio_played = false 

func _physics_process(delta):
	player_movement(delta)
	enemy_attack()
	attack()
	current_camera()
	update_health()
	
	if health <= 0:
		player_alive = false
		health = 0
		

func player_movement(delta):
	# Reset velocity for multi-directional movement
	if global.stop_character_control == true:
		return
		
	if not player_alive:
		if not death_animation_played:
			$AnimatedSprite2D.play("death")
			death_animation_played = true
			global.player_alive = false
		return
	velocity = Vector2.ZERO

	# Check input for movement
	if Input.is_action_pressed("ui_right"):
		velocity.x += SPEED
		current_dir = "right"
	if Input.is_action_pressed("ui_left"):
		velocity.x -= SPEED
		current_dir = "left"
	if Input.is_action_pressed("ui_down"):
		velocity.y += SPEED
		current_dir = "down"
	if Input.is_action_pressed("ui_up"):
		velocity.y -= SPEED
		current_dir = "up"

	# Normalize velocity for diagonal movement
	if velocity.length() > 0:
		velocity = velocity.normalized() * SPEED
		play_anim(1)  # Play walking animation
	else:
		play_anim(0)  # Play idle animation

	move_and_slide()

func play_anim(movement):
	if attack_ip:  # Prevent other animations from interrupting the attack animation
		return

	var anim = $AnimatedSprite2D

	# Check for diagonal bottom-right or bottom-left
	if velocity.x > 0 and velocity.y > 0:  # Bottom-right
		anim.flip_h = false
		anim.play("side_walk")
	elif velocity.x < 0 and velocity.y > 0:  # Bottom-left
		anim.flip_h = true
		anim.play("side_walk")
	else:
		# Handle regular directions
		match current_dir:
			"right":
				anim.flip_h = false
				anim.play("side_walk" if movement == 1 else "side_idle")
			"left":
				anim.flip_h = true
				anim.play("side_walk" if movement == 1 else "side_idle")
			"down":
				anim.flip_h = false
				anim.play("front_walk" if movement == 1 else "front_idle")
			"up":
				anim.flip_h = false
				anim.play("back_walk" if movement == 1 else "back_idle")

func player():
	pass

func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_inattack_range = true

func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_inattack_range = false

func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldown == true:
		health = health - 20
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		print(health)
		
		if health <= 0:
			if not death_audio_played:
				$death.play()
				death_audio_played = true 
		else:
			$hit.play()
		
		# Flash the sprite red
		$AnimatedSprite2D.modulate = Color(1, 0, 0)  # Set sprite to red
		
		# Wait for a short duration using await
		await get_tree().create_timer(0.2).timeout
		$AnimatedSprite2D.modulate = Color(1, 1, 1)  # Reset sprite color to normal

func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true

func attack():
	if global.stop_character_control == true:
		return
		
	if not player_alive:
		if not death_animation_played:
			$AnimatedSprite2D.play("death")
			death_animation_played = true
			global.player_alive = true
		return
	var dir = current_dir
	
	if Input.is_action_just_pressed("attack"):
		global.player_current_attack = true
		attack_ip = true 
		$sword.play() # Set attack in progress
		if dir == "right":
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("side_attack")
			$deal_attack_timer.start()
		elif dir == "left":
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("side_attack")
			$deal_attack_timer.start()

		elif dir == "down":
			$AnimatedSprite2D.play("front_attack")
			$deal_attack_timer.start()
		elif dir == "up":
			$AnimatedSprite2D.play("back_attack")
			$deal_attack_timer.start()

func _on_deal_attack_timer_timeout():
	$deal_attack_timer.stop()
	attack_ip = false  # Reset attack state
	global.player_current_attack = false

func current_camera():
	if global.current_scene == "world":
		$world_camera.enabled = true
		$cliffside_camera.enabled = false
		$ambush_camera.enabled = false
	elif global.current_scene == "cliff_side":
		$world_camera.enabled = false
		$cliffside_camera.enabled = true
		$ambush_camera.enabled = false
	elif global.current_scene == "ambush":
		$world_camera.enabled = false
		$cliffside_camera.enabled = false
		$ambush_camera.enabled = true
		
func update_health():
	var healthbar = $healthbar
	
	healthbar.value = health
	
	if health >= 100:
		healthbar.visible = false
	else:
		healthbar.visible = true

func _on_regin_timer_timeout():
	if health < 100:
		health += 20
		if health > 100:
			health = 100
	if health <= 0:
		health =0
