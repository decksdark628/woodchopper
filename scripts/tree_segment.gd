
# The tree_segment.gd script is attached to all segments, but in tree.gd, only tree[0] is connected to the segment_died signal (likely via the first segment set in the editor).

extends Node2D

const Branch = WChData.BranchDirection

signal segment_died

@onready var segment_sprite: Sprite2D = $SegmentSprite
@onready var breaking_anim: Sprite2D = $BreakingAnim
@onready var branch_sprite: Sprite2D = $BranchSprite
var branch:Branch
var hp:int

func _ready() -> void:
	#branch = Branch.NONE
	hp = WChData.MAX_SEGMENT_HP
	_update_sprite() #change later for a set_view or something

func decrease_hp(n:int):
	hp -= n
	if hp <= 0:
		segment_died.emit()
	_update_breaking_anim()

func set_branch(b:Branch):
	branch = b

func move_to_target_y(new_y:int) -> void:
	var animation = create_tween()
	animation.tween_property(
		self, "position:y", new_y, WChData.SEGM_FALL_DURATION
		)\
		.set_trans(Tween.TRANS_BACK)\
		.set_ease(Tween.EASE_OUT)

func _update_breaking_anim():
	var frame:int = WChData.MAX_SEGMENT_HP - hp
	if frame >= 0 && frame <= WChData.MAX_BREAK_ANIM_SPRITES:
		breaking_anim.frame = frame
	else:
		breaking_anim.frame = WChData.MAX_BREAK_ANIM_SPRITES

func _update_sprite():
	match branch:
		Branch.LEFT:
			print("left")
			branch_sprite.set_flip_h(true)
			branch_sprite.position = Vector2(-256,12)
			branch_sprite.visible = true
		Branch.NONE:
			print("center")
			segment_sprite.frame = randi_range(0, WChData.NUM_CENTER_SPRITES - 1)
		Branch.RIGHT:
			print("right")
			#position = Vector2(256,12)
			branch_sprite.visible = true
		_:
			printerr("tree_chunk.gd: BranchDirection invalido")
