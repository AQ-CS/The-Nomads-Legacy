extends Node

var ship_crash = false
var camel_crash = false
var stop_character_control = false





var player_current_attack = false
var current_scene = "world"
var transition_scene = false
var transition_to_ambush = false
var player_alive = true


var player_exit_ambush_to_world_posx = 343
var player_exit_ambush_to_world_posy = 272
var player_exit_cliffside_posx = 474
var player_exit_cliffside_posy = 28
var player_start_posx = 13
var player_start_posy = 75

var game_first_loadin = true



func finish_changescenes():
	if transition_scene:
		transition_scene = false
		
		if current_scene == "world":
			current_scene = "cliff_side"
			get_tree().change_scene_to_file("res://sceness/cliff_side.tscn")
		elif current_scene == "cliff_side":
			current_scene = "world"
			get_tree().change_scene_to_file("res://sceness/world.tscn")
		elif current_scene == "ambush": 
			current_scene = "world"
			get_tree().change_scene_to_file("res://sceness/world.tscn")
			
