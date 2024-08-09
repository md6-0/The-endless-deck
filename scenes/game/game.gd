extends Node2D

@onready var game_gui = $GameGui
@onready var game_over = $GameOver
var time = 0
@onready var player = $Player

func _ready():
	GLOBAL.create_hand()

func _process(delta):
	time += delta

func _on_player_player_died():
	RUNINFORMATION.run_time = time
	RUNINFORMATION.distance = player.global_position.x
	game_gui.hide_game_gui()
	game_over.show_game_over_overlay()
