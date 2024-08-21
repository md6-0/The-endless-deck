extends Area2D

@onready var audio_stream_player = $AudioStreamPlayer
@onready var sprite_2d = $Sprite2D

func _on_body_entered(body):
	if body is Player:
		GLOBAL.coins += 1
		RUNINFORMATION.collected_coins += 1
		sprite_2d.visible = false
		audio_stream_player.play()

func _on_audio_stream_player_finished():
	queue_free()
