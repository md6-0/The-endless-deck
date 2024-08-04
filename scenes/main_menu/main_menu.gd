extends Control

@onready var play_button = $Buttons/Play_button
@onready var focus_sound = $Buttons/Focus_sound

func _ready():
	play_button.grab_focus()

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://scenes/game/game.tscn")

func _on_settings_button_pressed():
	pass

func _on_exit_button_pressed():
	get_tree().quit()

func play_focus_sound():
	focus_sound.play()

func _on_shop_button_pressed():
	get_tree().change_scene_to_file("res://scenes/shop/shop.tscn")
