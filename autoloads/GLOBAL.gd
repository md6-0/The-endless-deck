extends Node

const HAND_SIZE: int = 4
var rng = RandomNumberGenerator.new()
var coins: int = 5000
var gemes: int
var deck: Array

var hand: Array
var card: String

func _ready():
	deck = ["Shoot", "Jump"]
	create_hand()

func create_hand():
	for i in HAND_SIZE:
		hand.insert(i,deck[int(rng.randf_range(0,deck.size()))])

func substitute_card(pos:int):
	hand[pos] = deck[int(rng.randf_range(0,deck.size()))]

func get_card(pos:int):
	card = hand[pos]
	hand[pos] = "none"
	return card
	
func get_hand():
	return hand
	
