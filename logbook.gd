extends Area2D

@onready var sprite = $AnimatedSprite2D  # Reference to the book's sprite
@onready var lHead = $left_head
@onready var rHead = $right_head
@onready var leftPage = $left_page
@onready var rightPage = $right_page
@onready var leftBtn = $btn_left
@onready var rightBtn = $btn_right
@onready var title = $title
@onready var goldIcon = $gold
@onready var silkIcon = $silk
@onready var bookIcon = $books
@onready var spicesIcon = $spices
@onready var miss1Icon = $mission1
@onready var miss2Icon = $mission2
@onready var miss3Icon = $mission3
@onready var miss4Icon = $mission4
@onready var miss5Icon = $mission5
@onready var miss6Icon = $mission6
@onready var miss7Icon = $mission7

var is_open = false  # Tracks whether the book is open or not
var current_page = 0  # Tracks the current page
var total_pages = 3

func _ready():
	hide()  # Hide the log book initially
	lHead.hide()
	rHead.hide()
	leftPage.hide()
	rightPage.hide()
	leftBtn.hide()
	rightBtn.hide()
	title.hide()
	goldIcon.hide()
	silkIcon.hide()
	bookIcon.hide()
	spicesIcon.hide()
	miss1Icon.hide()
	miss2Icon.hide()
	miss3Icon.hide()
	miss4Icon.hide()
	miss5Icon.hide()
	miss6Icon.hide()
	miss7Icon.hide()

func _process(delta):
	if State.in_dialogue == true:
		return
	if Input.is_action_just_pressed("ui_cancel"):  # Toggle visibility with ui_cancel
		if visible:
			current_page = 0
			close_logbook()
		else:
			open_logbook()

func _unhandled_input(event):
	if visible and is_open:
		if event.is_action_pressed("ui_right"):
			if current_page < total_pages:
				current_page += 1
				title.hide()
				sprite.play("open")
				update_pages()
			else:
				rightBtn.hide()
				print("You are already on the last page!")

		elif event.is_action_pressed("ui_left"):
			if current_page > 1:
				current_page -= 1
				update_pages()
			else:
				current_page -=1
				_ready()
				open_logbook()

func open_logbook():
	current_page = 0
	show()
	title.show()
	sprite.play("not_open")
	is_open = true

func close_logbook():
	_ready()
	is_open = false

func update_pages():
	print("Current page: ", current_page)
	if current_page == 1:
		lHead.show()
		rHead.show()
		leftPage.show()
		rightPage.show()
		leftBtn.show()
		rightBtn.show()
		lHead.text = "Items"
		goldIcon.show()
		bookIcon.show()
		spicesIcon.show()
		silkIcon.show()
		miss1Icon.show()
		leftPage.text = "    Gold: " + str(State.gold) + "\n\n    Silk: " + str(State.silk) + "\n\n    Spices: " + str(State.spices) + "\n\n    Books: " + str(State.books)
		rHead.text = "Missions"
		rightPage.text = "    Give Father An Apple"
		if State.mis1_status == "Complete":
			rightPage.text += "\n    Trade with Silk Trader \n    Outside"
			miss2Icon.show()
			# Access the AnimatedSprite2D and play the "completed" animation
			var miss1_sprite = miss1Icon.get_node("AnimatedSprite2D")
			if miss1_sprite:
				miss1_sprite.play("completed")
			
		if State.mis2_status == "Complete":
			rightPage.text += "\n    Talk to Ministers"
			miss3Icon.show()
			# Access the AnimatedSprite2D and play the "completed" animation
			var miss2_sprite = miss2Icon.get_node("AnimatedSprite2D")
			if miss2_sprite:
				miss2_sprite.play("completed")
				
		if State.mis3_status == 2:
			rightPage.text += "\n    Talk with Sultan"
			miss4Icon.show()
			# Access the AnimatedSprite2D and play the "completed" animation
			var miss3_sprite = miss3Icon.get_node("AnimatedSprite2D")
			if miss3_sprite:
				miss3_sprite.play("completed")
				
		if State.mis4_status == "Complete":
			var miss3_sprite = miss3Icon.get_node("AnimatedSprite2D")
			if miss3_sprite:
				miss3_sprite.play("completed")

	elif current_page == 2:
		rightBtn.show()
		goldIcon.hide()
		silkIcon.hide()
		bookIcon.hide()
		spicesIcon.hide()
		miss1Icon.hide()
		miss2Icon.hide()
		miss3Icon.hide()
		miss4Icon.hide()
		miss5Icon.hide()
		miss6Icon.hide()
		miss7Icon.hide()
		lHead.text = "Travel Log"
		rHead.text = "Page 4"
		leftPage.text = ""
		rightPage.text = ""
		if global2.leavingMorocco == true:
			leftPage.text += "I departed Tangier, driven \nby faith, to perform the \npilgrimage to Mecca."
		if global2.visitedMecca == true:
			leftPage.text += "\n\nAfter Mecca, my travels \ncarried me to distant lands \nin pursuit of knowledge \nand adventure."
		if global2.visitedIndia == true:
			leftPage.text += "\n\nI journeyed to India, lured \nby tales of its grandeur \nand wealth."
		
	elif current_page == 3:
		goldIcon.hide()
		silkIcon.hide()
		bookIcon.hide()
		spicesIcon.hide()
		rightBtn.hide()
		miss1Icon.hide()
		miss2Icon.hide()
		miss3Icon.hide()
		miss4Icon.hide()
		miss5Icon.hide()
		miss6Icon.hide()
		miss7Icon.hide()
		lHead.text = "Page 5"
		rHead.text = "Page 6"
		leftPage.text = ""
		rightPage.text = ""
