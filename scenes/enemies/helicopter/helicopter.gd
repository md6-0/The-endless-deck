extends Node2D

@onready var audio_stream_player = $Dead_sound
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var area_2d = $Area2D

@onready var amplitude = 50.0
@onready var speed = 2.0 
@onready var initial_position = global_position

var time_passed = 0.0
var phase_offset = randf_range(0.0, TAU)
var is_dead: bool
var killed_by_shoot: bool


func _physics_process(delta):
	if not is_dead:
		time_passed += delta
		global_position.y = initial_position.y + amplitude * sin(speed * time_passed + phase_offset)
	else:
		var new_gpos = 0
		
		if global_position.y < 216:
			new_gpos = int(global_position.y)
			new_gpos += 1
			global_position.y = new_gpos
			
		elif  global_position.y > 216:
			new_gpos = int(global_position.y)
			new_gpos -= 1
			global_position.y = new_gpos
			
		elif  global_position.y == 216:
			global_position.y = 216


#Función que detecta cuerpos colisionando con el enemigo
#Ahora se usa sólo para detectar al personaje
func _on_area_2d_body_entered(body):
	if body is Player and not body.is_dead:
		area_2d.queue_free()
		animated_sprite_2d.visible = false
		body.damage_ctrl(1)
		audio_stream_player.play()


#Función que detecta areas colisionando con el enemigo
#Ahora se usa sólo para las balas del personaje
func _on_area_2d_area_entered(area):
	if area.is_in_group("shoot"):
		killed_by_shoot = true
		area_2d.queue_free()
		area.queue_free()
		animated_sprite_2d.play("dead")
		is_dead = true
		#audio_stream_player.play()

#Cuando el audio acaba, eliminamos al personaje.
func _on_audio_stream_player_finished():
	RUNINFORMATION.enemmies_killed += 1
	if killed_by_shoot:
		#spawn_gemes()
		pass
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
