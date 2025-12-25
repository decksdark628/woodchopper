extends Node2D

const LOG_SIZE:int = 128

@export var tree_chunk:PackedScene
var log_pile:Array

func _ready() -> void:
	log_pile = []
	for i in range(4):
		add_to_top(0)

func add_to_top(type:int):
	var chunk = tree_chunk.instantiate()
	add_child(chunk)
	chunk.set_type(type)
	log_pile.append(chunk)
	update_positions()

func remove_first():
	if not log_pile.is_empty():
		var rand = randi_range(-1, 1)
		if log_pile.back().type == -1:
			rand = randi_range(-1, 0)
		elif log_pile.back().type == 1:
			rand = randi_range(0 , 1)
		add_to_top(rand)
		log_pile[0].queue_free()
		log_pile.pop_front()
		update_positions()

func update_positions():
	for i in log_pile.size():
		log_pile[i].position.y = LOG_SIZE * -i
