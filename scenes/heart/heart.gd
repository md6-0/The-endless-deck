extends Area2D

@onready var audio_stream_player = $AudioStreamPlayer
@onready var sprite_2d = $Heart

func _on_body_entered(body):
	if body is Player:
		if body.health > 0:
			body.health += 1
			sprite_2d.visible = false
			audio_stream_player.play()
			RUNINFORMATION.collected_hearts += 1

func _on_audio_stream_player_finished():
	queue_free()
