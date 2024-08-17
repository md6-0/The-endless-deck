extends Node2D

@onready var sprite_2d = $TurretSpider_sprite
@onready var player_detected = false
@onready var shoot_timer = $Shoot_Timer
@onready var turret_shoot = preload("res://scenes/enemies/turret/turret_shoot.tscn")
@onready var shoot_position = $Marker2D
@onready var dead_sound = $Dead_sound
@onready var turret_spider_sprite = $TurretSpider_sprite
@onready var is_dead: bool = false
var player

func _process(delta):
	if is_dead:
		global_position.y -= 30 * delta

func _on_detection_area_2d_body_entered(body):
	if body is Player and not body.is_dead:
		player = body
		player_detected = true
		shoot()
		shoot_timer.start()

func _on_detection_area_2d_body_exited(body):
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

#Función que detecta cuerpos colisionando con el enemigo
#Ahora se usa sólo para detectar al personaje
func _on_collision_area_2d_body_entered(body):
	if body is Player and not body.is_dead:
		is_dead = true
		shoot_timer.stop()
		body.damage_ctrl(1)
		dead_sound.play()

#Función que detecta areas colisionando con el enemigo
#Ahora se usa sólo para las balas del personaje
func _on_collision_area_2d_area_entered(area):
	if area.is_in_group("shoot"):
		is_dead = true
		shoot_timer.stop()
		area.play_hit_animation()
		dead_sound.play()
