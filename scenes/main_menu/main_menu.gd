extends Control

@onready var play_button = $Buttons/Play_button
@onready var focus_sound = $Buttons/Focus_button
@onready var click_button = $Buttons/Click_button

func _ready():
	play_button.grab_focus()

func _on_play_button_pressed():
	play_click_sound()

func _on_settings_button_pressed():
	play_click_sound()

func _on_exit_button_pressed():
	play_click_sound()
	get_tree().quit()

func play_focus_sound():
	focus_sound.play()

func play_click_sound():
	focus_sound.stop()
	click_button.play()
