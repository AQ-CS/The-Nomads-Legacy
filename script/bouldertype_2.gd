extends Area2D

func _on_body_entered(body):
	global.ship_crash = true
	print("you crashed")
