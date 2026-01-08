extends Node2D

const Branch = WChData.BranchDirection

signal segment_died

@onready var chunk: ColorRect = $sprTreeChunk
@onready var segment_sprite: Sprite2D = $SegmentSprite
@onready var breaking_anim: Sprite2D = $BreakingAnim
var branch:Branch
var hp:int
var target_y:int

func _ready() -> void:
	branch = Branch.NONE
	hp = WChData.MAX_SEGMENT_HP
	target_y = 0
	_update_sprite() #change later for a set_view or something

func decrease_hp(n:int):
	hp -= n
	_update_breaking_anim()
	if hp <= 0:
		segment_died.emit()

func set_branch(b:Branch):
	branch = b

func set_target_y(n:int):
	target_y = n

func move_to_target_y() -> void:
	var animation = create_tween()
	animation.tween_property(
		self, "position.y", target_y, WChData.SEGM_FALL_DURATION
		)\
		.set_trans(Tween.TRANS_BACK)\
		.set_ease(Tween.EASE_OUT)

func _update_breaking_anim():
	var frame:int = WChData.MAX_SEGMENT_HP - hp
	if frame >= 0 && frame <= WChData.MAX_SEGMENT_HP:
		breaking_anim.frame = frame
	else:
		printerr("tree_segment: _update_breaking_anim error. HP, MAX_HP or Damage are incorrect wrong")

func _update_sprite():
	match branch:
		Branch.LEFT:
			chunk.size.x = WChData.GRID_SIZE * 2
			chunk.position.x = -192
			chunk.color = Color(0.0, 0.642, 0.266, 1.0)
		Branch.NONE:
			segment_sprite.frame = randi_range(0, WChData.NUM_CENTER_SPRITES - 1)
		Branch.RIGHT:
			chunk.size.x = WChData.GRID_SIZE * 2
			chunk.position.x = -64
			chunk.color = Color(0.98, 0.119, 0.0, 1.0)
		_:
			printerr("tree_chunk.gd: BranchDirection invalido")
