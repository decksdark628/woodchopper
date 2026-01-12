extends Node2D

const Branch = WChData.BranchDirection
const LEFT_POS:Vector2 = Vector2(-220, 230)
const RIGHT_POS:Vector2 = Vector2(220, 230)

@onready var sprite_2d: Sprite2D = $Sprite2D
@export var tree:Node2D
var hp:int
var dmg:int
var on_left_side:bool
var can_cut:bool
signal axe_swung

func _ready() -> void:
	initialize_state()

func initialize_state() -> void:
	hp = 1
	dmg = 1 #TODO: set based on item used
	on_left_side = true
	position = LEFT_POS
	can_cut = true

func cut():
	if can_cut:
		emit_signal("axe_swung", dmg)

func move_left():
	position = LEFT_POS
	sprite_2d.set_flip_h(false)
	on_left_side = true

func move_right():
	position = RIGHT_POS
	sprite_2d.set_flip_h(true)
	on_left_side = false

func reduce_hp():
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

func _on_tree_tree_anim_finished(br_dir:Branch) -> void:
	if (br_dir == Branch.LEFT && on_left_side) or (br_dir == Branch.RIGHT && !on_left_side):
		reduce_hp()
	can_cut = true
