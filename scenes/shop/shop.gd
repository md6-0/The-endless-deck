extends Control

var items = []
@onready var item_grid = $ScrollContainer/GridContainer
@onready var coins_label = $Header/Coins_label
@onready var menu_button = $Header/Menu_button
@onready var play_button = $Header/Play_button
@onready var focus_sound = $Focus_sound

func _ready():
	items = preload("res://scenes/shop/shop_inventory.gd").ITEMS
	coins_label.text = "Coins: " + str(GLOBAL.coins)
	update_credits_label()
	populate_shop()

func _process(_delta):
	update_credits_label()

func update_credits_label():
	coins_label.text = "Coins: " + str(GLOBAL.coins)

func populate_shop():
	var index = 0
	for item_data in items:
		var item_container = preload("res://scenes/shop/shop_item_card.tscn").instantiate()
		item_container.item_name = item_data.name
		item_container.item_icon = item_data.icon
		item_container.item_description = item_data.description
		item_container.item_credits = item_data.price
		
		if GLOBAL.deck:
			for item in GLOBAL.deck:
				if item_data.name == item:
					item_container.item_sold = true
		else: item_container.item_sold = false
		item_container.custom_minimum_size = Vector2(130,180)
		item_grid.add_child(item_container)
		var added_button = item_grid.get_child(index).get_child(0)
		if index < 3:
			added_button.focus_neighbor_top = play_button.get_path()
		if index == 0:
			added_button.grab_focus()
		index += 1
	play_button.focus_neighbor_bottom = item_grid.get_child(0).get_child(0).get_path()

func play_focus_sound():
	focus_sound.play()

func _on_menu_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://scenes/game/game.tscn")

func _on_menu_button_focus_exited():
	focus_sound.play()
