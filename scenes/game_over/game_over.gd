extends Control

@onready var restart = $CanvasLayer/Restart
@onready var exit = $CanvasLayer/Exit
@onready var audio_stream_player = $AudioStreamPlayer

@onready var label_youdied = $CanvasLayer/Label_youdied
@onready var label_time = $CanvasLayer/Label_time
@onready var label_time_value = $CanvasLayer/Label_time_value
@onready var label_distance = $CanvasLayer/Label_distance
@onready var label_distance_value = $CanvasLayer/Label_distance_value
@onready var label_enemies = $CanvasLayer/Label_enemies
@onready var label_enemies_value = $CanvasLayer/Label_enemies_value
@onready var label_cards = $CanvasLayer/Label_cards
@onready var label_cards_value = $CanvasLayer/Label_cards_value
@onready var label_coins = $CanvasLayer/Label_coins
@onready var label_coins_value = $CanvasLayer/Label_coins_value
@onready var label_hearts = $CanvasLayer/Label_hearts
@onready var label_hearts_value = $CanvasLayer/Label_hearts_value
@onready var label_gemes = $CanvasLayer/Label_gemes
@onready var label_gemes_value = $CanvasLayer/Label_gemes_value

@onready var typing_timer = $Typing_timer

var labels = []
var full_texts = []
var current_texts = []
var char_indices = []
var label_index = 0

func star_game_over_overlay():
	restart.grab_focus()
	var time = RUNINFORMATION.run_time
	var minutes = int(time / 60)
	var seconds = int(time) % 60
	
	var str_seconds
	if seconds < 10:
		str_seconds = "0" + str(seconds)
	else: 
		str_seconds = str(seconds)
		
	var str_minutes
	if minutes < 10:
		str_minutes = "0" + str(minutes)
	else: 
		str_minutes = str(minutes)
	
	labels = [
		label_youdied,
		label_time,
		label_time_value,
		label_distance,
		label_distance_value,
		label_enemies,
		label_enemies_value,
		label_cards,
		label_cards_value,
		label_coins,
		label_coins_value,
		label_gemes,
		label_gemes_value,
		label_hearts,
		label_hearts_value
	]
	
	full_texts = [
		"You died",
		"Run time: ",
		str_minutes + ":" + str_seconds,
		"Distance: ",
		str(int(RUNINFORMATION.distance/35)) + "m",
		"Enemies killed: ",
		str(RUNINFORMATION.enemmies_killed),
		"Hearts collected: ",
		str(RUNINFORMATION.collected_hearts),
		"Coins collected: ",
		str(RUNINFORMATION.collected_coins),
		"Gems collected: ",
		str(RUNINFORMATION.collected_gems),
		"Cards used: ",
		str(RUNINFORMATION.cards_used),
		
	]
	
	current_texts = ["","", "", "", "", "", "","","", "", "", "", "", "", ""]
	char_indices = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
	
	typing_timer.start()

func show_game_over_overlay():
	$CanvasLayer.visible = true
	star_game_over_overlay()

func _on_typing_timer_timeout():
	if label_index < labels.size():
		if char_indices[label_index] < full_texts[label_index].length():
			current_texts[label_index] += full_texts[label_index][char_indices[label_index]]
			labels[label_index].text = current_texts[label_index]
			char_indices[label_index] += 1
		else:
			label_index += 1
	else:
		typing_timer.stop()

func _on_exit_pressed():
	get_tree().quit()

func _on_restart_pressed():
	RUNINFORMATION.reset_run_vars()
	get_tree().change_scene_to_file("res://scenes/game/game.tscn")

func _on_restart_focus_exited():
	audio_stream_player.play()

func _on_exit_focus_exited():
	audio_stream_player.play()

func _on_store_pressed():
	RUNINFORMATION.reset_run_vars()
	get_tree().change_scene_to_file("res://scenes/shop/shop.tscn")
