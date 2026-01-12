extends Node2D

@onready var timer: Timer = $Timer
@onready var label: Label = $TimerLabel
var game_over:bool
var wood_collected:int

func _ready() -> void:
	game_over = false
	wood_collected = 0

func _process(delta: float) -> void:
	if timer != null:
		label.text = str(ceil(timer.time_left))

func set_game_over():
	label.text = "GAME OVER"
	game_over = true

func _on_timer_timeout() -> void:
	timer.queue_free()
	set_game_over()
	
