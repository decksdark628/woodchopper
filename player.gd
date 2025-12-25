extends Node2D

const left_pos:Vector2 = Vector2(-192, 128)
const right_pos:Vector2 = Vector2(192, 128)

@onready var tree: Node2D = $"../tree"
var on_left_side:bool
var wood:int
var hp:int

func _ready() -> void:
	on_left_side = true
	wood = 0
	hp = 1

func cut():
	var branch_above:int = tree.log_pile[1].type
	if branch_above == -1 && on_left_side || branch_above == 1 && !on_left_side:
		player_take_damage()
	else:
		tree.remove_first()
		wood += 1
	print(wood)       

func move_left():
	self.position = left_pos
	on_left_side = true

func move_right():
	self.position = right_pos
	on_left_side = false

func player_take_damage():
	hp -= 1
	if hp == 0:
		print("Game Over")

func _input(event: InputEvent):
	if event.is_action_pressed("ui_accept"):
		cut()
	elif event.is_action_pressed("ui_left"):
		move_left()
	elif event.is_action_pressed("ui_right"):
		move_right()
