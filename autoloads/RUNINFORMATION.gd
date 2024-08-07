extends Node

var run_time: int
var distance: int
var enemmies_killed: int
var collected_hearts: int
var collected_coins: int
var collected_gems: int
var cards_used: int


func reset_run_vars():
	run_time = 0
	enemmies_killed = 0
	collected_hearts = 0
	collected_coins = 0
	collected_gems = 0
	cards_used = 0
