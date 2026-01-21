extends Node2D

@onready var timer: Timer = $Timer
@onready var label: Label = $TimerLabel
@onready var wood_counter: Label = $WoodCounter
@onready var game_over_screen: Node2D = $GameOverScreen
@onready var play_again: Button = $GameOverScreen/PlayAgain
@onready var go_back: Button = $GameOverScreen/GoBack
var game_over:bool
var wood_collected:int

func _ready() -> void:
	game_over = false
	wood_collected = 0
	game_over_screen.visible = false

func _process(delta: float) -> void:
	if !game_over and timer != null:
		label.text = str(ceil(timer.time_left))

func increase_wood_counter() -> void:
	wood_collected += 1
	wood_counter.text = str(wood_collected)
	

func set_game_over():
	if timer != null:
		timer.stop()
	game_over_screen.visible = true
	
	game_over = true

func _on_timer_timeout() -> void:
	timer.queue_free()
	label.text = str(0.0)
	set_game_over()
	
func _on_play_again_pressed() -> void:
	# pasar wood collected a GlobalData.wood
	get_tree().reload_current_scene()

func _on_return_pressed() -> void:
	# pasar wood collected a GlobalData.wood
	# ir de regreso al juego principal
	pass
