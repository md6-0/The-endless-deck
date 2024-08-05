extends Control

var item_id :int
var item_name :String
var item_icon :String
var item_description :String
var item_credits :int
var item_sold: bool

@onready var item_name_label = $Button/item_name_label
@onready var texture_rect = $Button/TextureRect
@onready var item_description_label = $Button/item_description_label
@onready var item_price_label = $Button/item_price_label
@onready var success_sound = $success_sound
@onready var error_sound = $error_sound


func _ready():
	item_name_label.text = item_name + " card"
	item_description_label.text = item_description
	item_price_label.text = str(item_credits) + " coins"
	if item_sold:
		set_items_as_sold()
	else: texture_rect.texture = load(item_icon)

func set_items_as_sold():
	item_sold = true
	texture_rect.texture = load("res://assets/visuals/sprites/sold.png")

func _on_buy_button_pressed():
	if GLOBAL.coins >= item_credits and not item_sold:
		set_items_as_sold()
		GLOBAL.coins -= item_credits
		GLOBAL.deck.append(item_name)
		success_sound.play()
		SAVEMANAGER.save_game()
	else:
		error_sound.play()
