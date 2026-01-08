extends Node2D

const LOG_SIZE:int = 256
const TREE_STARTING_Y_POS:int = 32
const Branch = WChData.BranchDirection

@export var tree_segment:PackedScene
@export var first_segment:Node2D
var tree:Array

func _ready() -> void:
	tree = []
	first_segment.position.y = TREE_STARTING_Y_POS
	tree.append(first_segment)
	for i in range(1, 3):
		add_segment()

#func add_to_top(type:int):
	#var chunk = tree_chunk.instantiate()
	#add_child(chunk)
	#chunk.set_type(type)
	#logs_pile.append(chunk)
	#update_positions()

#func remove_first():
	#if not logs_pile.is_empty():
		#var rand = randi_range(-1, 1)
		#if logs_pile.back().type == -1:
			#rand = randi_range(-1, 0)
		#elif logs_pile.back().type == 1:
			#rand = randi_range(0 , 1)
		#add_to_top(rand)
		#logs_pile[0].queue_free()
		#logs_pile.pop_front()
		#update_positions()

#func update_positions():
	#for i in logs_pile.size():
		#logs_pile[i].position.y = LOG_SIZE * -i

# VIEW




# CONTROLLER

func add_segment() -> void:
	var segment = _generate_segment()
	if segment != null:
		tree.append(segment)
		_update_positions()

func _update_positions():
	for i in tree.size():
		tree[i].position.y = 32 + (LOG_SIZE * -i)
		print("i: " +  str(i) + "pos_y: " + str(tree[i].position.y))

func _generate_segment() -> Node2D:
	var previous:Branch = tree.back().branch
	var new:Branch = _choose_branch(previous)
	var segment = tree_segment.instantiate()
	segment.set_branch(new)
	return segment

func _choose_branch(previous:Branch) -> Branch:
	var options
	if previous == Branch.LEFT:
		options = [Branch.LEFT, Branch.NONE]
	elif previous == Branch.RIGHT:
		options = [Branch.NONE, Branch.RIGHT]
	else:
		options = [Branch.LEFT, Branch.NONE, Branch.RIGHT]
	return options.pick_random()

# MODEL

func _poll() -> void:
	if not tree.is_empty():
		tree[0].queue_free()
		tree.pop_front()
