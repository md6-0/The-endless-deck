extends Node2D

@onready var sprite_2d = $TurretSpider_sprite
@onready var player_detected = false
@onready var shoot_timer = $Shoot_Timer
@onready var turret_shoot = preload("res://scenes/enemies/turret/turret_shoot.tscn")
@onready var shoot_position = $Marker2D

var player

func _on_area_2d_body_entered(body):
	if body is Player and not body.is_dead:
		player = body
		player_detected = true
		shoot()
		shoot_timer.start()

func _on_area_2d_body_exited(body):
	if body is Player and not body.is_dead:
		player_detected = false
		shoot_timer.stop()

func shoot():
	var projectile = turret_shoot.instantiate()
	projectile.global_position = shoot_position.global_position
	var direction = (player.global_position + Vector2(randf_range(100, 225),0) - shoot_position.global_position).normalized()
	projectile.direction = direction
	get_tree().call_group.call_deferred("level", "add_child", projectile)

func _on_shoot_timer_timeout():
	shoot()

func _on_visible_on_screen_notifier_2d_screen_exited():
	shoot_timer.stop()
	queue_free()
