extends Node2D

@onready var dead_sound = $Dead_sound
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var area_2d = $Area2D
@onready var speed = 20.0 
var is_dead = false

func _physics_process(delta):
	if not is_dead:
		global_position.x += -speed * delta

#Función que detecta cuerpos colisionando con el enemigo. Ahora se usa sólo para la colisión con el personaje
func _on_area_2d_body_entered(body):
	if body is Player and not body.is_dead:
		area_2d.queue_free()
		body.damage_ctrl(1)
		animated_sprite_2d.play("dead")
		RUNINFORMATION.enemmies_killed += 1
		dead_sound.play()

#Función que detecta areas colisionando con el enemigo. Ahora se usa sólo para las balas del personaje
func _on_area_2d_area_entered(area):
	if area.is_in_group("shoot"):
		area.play_hit_animation()
		is_dead = true
		area_2d.queue_free()
		animated_sprite_2d.play("dead")
		RUNINFORMATION.enemmies_killed += 1
		dead_sound.play()

func _on_visible_on_screen_notifier_2d_screen_exited():
		queue_free()
