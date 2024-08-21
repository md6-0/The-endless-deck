extends Control

var a: Sprite2D
var b: Sprite2D
var x: Sprite2D
var y: Sprite2D
var heart_texture: CompressedTexture2D
var hearts_h_box_container: HBoxContainer
var hand: Array
var player

func _ready():
	a = $CanvasLayer/A_Sprite2D
	b = $CanvasLayer/B_Sprite2D
	x = $CanvasLayer/X_Sprite2D
	y = $CanvasLayer/Y_Sprite2D
	hearts_h_box_container = $CanvasLayer/Hearts_HBoxContainer
	heart_texture = preload("res://assets/visuals/sprites/heart/heart.png")
	player = get_tree().get_nodes_in_group("player")[0]  

func _process(_delta):
	update_cards_gui()
	populate_hearts()

func populate_hearts():
	# Limpiamos el contenedor
	for child in hearts_h_box_container.get_children():
		child.free()
	
	# Añadimos un corazón por cada vida del jugador
	for i in range(player.health):
		var heart = TextureRect.new()
		heart.texture = heart_texture
		heart.modulate = Color(1, 0, 0)
		hearts_h_box_container.add_child(heart)

func update_cards_gui():
	hand = GLOBAL.get_hand()
	update_sprite(a, hand[0])
	update_sprite(b, hand[1])
	update_sprite(x, hand[2])
	update_sprite(y, hand[3])

func update_sprite(sprite: Sprite2D, action: String):
	match action:
		"Jump":
			sprite.texture = load("res://assets/visuals/sprites/cards/jump_card.png")
		"Dash":
			sprite.texture = load("res://assets/visuals/sprites/cards/dash_card.png")
		"Shoot":
			sprite.texture = load("res://assets/visuals/sprites/cards/shoot_card.png")
		"Tsunami":
			sprite.texture = load("res://assets/visuals/sprites/cards/tsunami_card.png")
		_:
			sprite.texture = load("res://assets/visuals/sprites/cards/empty_card.png")

func hide_game_gui():
	$CanvasLayer.visible = false
