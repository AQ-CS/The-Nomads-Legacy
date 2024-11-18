extends CharacterBody2D

var speed = 40
var player_chase = false
var player = null

var health = 100
var player_inattack_zone = false
var can_take_damage = true


func _physics_process(delta):
	if global.player_alive == false:
		player_chase = false
	
	deal_with_damage()
	update_health()
	
	
	if player_chase:
		var direction = (player.position - position).normalized()  # Get normalized direction vector
		position += (player.position - position).normalized() * speed * delta

		# Determine the animation based on the direction
		if abs(direction.x) > abs(direction.y):  # Horizontal movement
			if direction.x > 0:
				$AnimatedSprite2D.flip_h = false  # Face right
			else:
				$AnimatedSprite2D.flip_h = true  # Face left
			$AnimatedSprite2D.play("side_walk")  # Single side animation
		else:  # Vertical movement
			if direction.y > 0:
				$AnimatedSprite2D.play("front_walk")
			else:
				$AnimatedSprite2D.play("back_walk")
	else:
		# Default idle animation
		$AnimatedSprite2D.play("idle_front")


func _on_detection_area_body_entered(body):
	player = body
	player_chase = true

func _on_detection_area_body_exited(body):
	player = null
	player_chase = false

func enemy():
	pass


func _on_enemy_hitbox_body_entered(body):
	if body.has_method("player"):
		player_inattack_zone = true


func _on_enemy_hitbox_body_exited(body):
	if body.has_method("player"):
		player_inattack_zone = false

func deal_with_damage():
	if player_inattack_zone and global.player_current_attack == true:
		if can_take_damage == true:
			health = health - 20
			$take_damage_cooldown.start()
			can_take_damage = false
			print("enemy health: ",health)
		# Flash the sprite red
			$AnimatedSprite2D.modulate = Color(1, 0, 0)  # Set sprite to red
			# Wait for a short duration using await
			await get_tree().create_timer(0.2).timeout
			$AnimatedSprite2D.modulate = Color(1, 1, 1)  # Reset sprite color to normal
			if health <= 0:
				$kill.play()
				player_inattack_zone = false
				player_chase = false
				await get_tree().create_timer(1).timeout
				self.queue_free()


func _on_take_damage_cooldown_timeout():
	can_take_damage = true

func update_health():
	var healthbar = $healthbar
	
	healthbar.value = health
	
	if health >= 100:
		healthbar.visible = false
	else:
		healthbar.visible = true
