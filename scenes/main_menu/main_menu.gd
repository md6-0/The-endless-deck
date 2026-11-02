extends Control

@onready var play_button = $Buttons/Play_button
@onready var focus_sound = $Buttons/Focus_sound

func _ready():
	play_button.grab_focus()
	# En el navegador el juego no puede cerrar la pestaña: el botón no haría nada.
	# Se deja invisible y sin foco (no se oculta para no descolocar la cuadrícula).
	if OS.has_feature("web"):
		var exit_button = $Buttons/Exit_button
		exit_button.disabled = true
		exit_button.focus_mode = Control.FOCUS_NONE
		exit_button.modulate.a = 0.0

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


func _on_delete_save_button_pressed():
	SAVEMANAGER.delete_save()
