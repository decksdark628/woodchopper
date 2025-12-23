extends Node2D

@onready var chunk: ColorRect = $sprTreeChunk
var type:int

func _ready() -> void:
	type = 0

func set_type(n:int):
	type = n
	match type:
		-1:
			chunk.scale = Vector2(2, 1)
			chunk.position = Vector2(-64, 0)
		0:
			chunk.scale = Vector2(1, 1)
		1:
			chunk.scale = Vector2(2, 1)
			chunk.position = Vector2(64, 0)

func _input(event: InputEvent):
	if event.is_action_pressed("ui_left"):
		print("left")
		set_type(-1)
	elif event.is_action_pressed("ui_right"):
		set_type(1)
	elif event.is_action_pressed("ui_accept"):
		set_type(0)
