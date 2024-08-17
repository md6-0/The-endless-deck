extends Area2D

const SPEED = 700
var hitted = false

func _process(delta):
	if not hitted:
		global_position.x += SPEED * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func play_hit_animation():
	hitted = true
	$AnimatedSprite2D.play("hit")

func _on_animated_sprite_2d_animation_finished():
	queue_free()
