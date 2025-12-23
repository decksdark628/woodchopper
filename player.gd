extends Node2D

const left_pos:Vector2 = Vector2(-192, 128)
const right_pos:Vector2 = Vector2(192, 128)

var on_left_side:bool

func _ready() -> void:
	on_left_side = true

func cut():
	print("cut")

func move_left():
	self.position = left_pos
	on_left_side = true

func move_right():	
	self.position = right_pos
	on_left_side = false

func _input(event: InputEvent):
	if event.is_action_released("ui_accept"):
		cut()
	elif event.is_action_released("ui_left"):
		move_left()
	elif event.is_action_released("ui_right"):
		move_right()
