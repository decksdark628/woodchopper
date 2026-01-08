extends Node2D

const LEFT_POS:Vector2 = Vector2(-220, 230)
const RIGHT_POS:Vector2 = Vector2(220, 230)

@export var tree:Node2D
var hp:int
var dmg:int
var on_left_side:bool
var wood:int

func _ready() -> void:
	initialize_state()

func initialize_state() -> void:
	hp = 1
	wood = 0
	dmg = 1 #TODO: set based on item used
	on_left_side = true

func cut():
	var branch_above:int = tree.log_pile[1].type
	if branch_above == -1 && on_left_side || branch_above == 1 && !on_left_side:
		player_take_damage()
	else:
		tree.remove_first()
		wood += 1
	print(wood)       

func move_left():
	self.position = LEFT_POS
	on_left_side = true

func move_right():
	self.position = RIGHT_POS
	on_left_side = false

func player_take_damage():
	hp -= 1
	if hp == 0:
		print("Game Over")

func _input(event: InputEvent):
	if hp > 0:
		if event.is_action_pressed("ui_accept"):
			cut()
		elif event.is_action_pressed("ui_left"):
			move_left()
		elif event.is_action_pressed("ui_right"):
			move_right()
