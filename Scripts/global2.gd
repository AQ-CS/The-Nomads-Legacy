extends Node

var player_current_attack = false
var goingIndia = false
var goingSultan = false
var goingMin1 = false
var goingMin2 = false
var goingIndiaSide = false
var goingHouse = false
var goingTown = false
var goingEgypt = false
var goingMorocco = false
var goingShip = false
var goingCamel = false
var visitedIndia = false
var leavingMorocco = false
var visitedMecca = false

func changeBack():
	if goingHouse == true:
		goingHouse = false
	elif goingTown == true:
		goingTown = false
	elif goingEgypt == true:
		goingEgypt = false
	elif goingIndia == true:
		goingIndia = false
	elif goingSultan == true:
		goingSultan = false
	elif goingMin1 == true:
		goingMin1 = false
	elif goingMin2 == true:
		goingMin2 = false
	elif goingIndiaSide == true:
		goingIndiaSide = false
	elif goingMorocco == true:
		goingMorocco = false
	elif goingShip == true:
		goingShip = false
	elif goingCamel == true:
		goingCamel = false
