extends Control

var a: Sprite2D
var b: Sprite2D
var x: Sprite2D
var y: Sprite2D
var health_label: Label
var hand: Array
var player

func _ready():
	a = $CanvasLayer/A_Sprite2D
	b = $CanvasLayer/B_Sprite2D
	x = $CanvasLayer/X_Sprite2D
	y = $CanvasLayer/Y_Sprite2D
	health_label = $CanvasLayer/Health_Label
	player = get_tree().get_nodes_in_group("player")[0]  

func _process(_delta):
	update_healt_label()
	update_cards_gui()

func update_healt_label():
	health_label.text = "Health: " + str(player.health)

func update_cards_gui():
	hand = GLOBAL.get_hand()
	update_sprite(a, hand[0])
	update_sprite(b, hand[1])
	update_sprite(x, hand[2])
	update_sprite(y, hand[3])

func update_sprite(sprite: Sprite2D, action: String):
	match action:
		"Jump":
			sprite.texture = load("res://assets/visuals/sprites/24-sprite-yellow.png")
		"Dash":
			sprite.texture = load("res://assets/visuals/sprites/24-sprite-red.png")
		"Shoot":
			sprite.texture = load("res://assets/visuals/sprites/24-sprite-blue.png")
		_:
			sprite.texture = load("res://assets/visuals/sprites/24-sprite-grey.png")

func hide_game_gui():
	$CanvasLayer.visible = false
