extends Node2D

const GRID_SIZE:int = 128

@onready var chunk: ColorRect = $sprTreeChunk
var type:int

func _ready() -> void:
	type = 0

func set_type(n:int):
	type = n
	match type:
		-1:
			print("left")
			chunk.size.x = GRID_SIZE * 2
			chunk.position.x = -192
			chunk.color = Color(0.0, 0.642, 0.266, 1.0)
		0:
			print("center")
		1:
			print("right")
			chunk.size.x = GRID_SIZE * 2
			chunk.position.x = -64
			chunk.color = Color(0.98, 0.119, 0.0, 1.0)
		_:
			print("otro numero")
