extends CharacterBody2D
class_name Player

signal player_died

const SPEED = 175.0
const JUMP_VELOCITY = -375.0
const DASH_SPEED = 600.0
const DASH_TIME = 0.35
@onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

const SHAKE_AMOUNT = 5
const SHAKE_DURATION = 0.2
@onready var camera = $Camera2D
@onready var shake_amount = 0.0
@onready var shake_duration = 0.0

@onready var is_dead = false
@onready var health: int = 3
@onready var is_dashing = false
@onready var dash_timer = 0.0

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var collision_shape_2d = $CollisionShape2D
@onready var shoots_collision_shape_2d = $Shoots_Area2D/Shoots_CollisionShape2D


@onready var x_timer = $Timers/X_Timer
@onready var y_timer = $Timers/Y_Timer
@onready var a_timer = $Timers/A_Timer
@onready var b_timer = $Timers/B_Timer
@onready var game_over_timer = $Timers/Game_over_Timer

@onready var proyectile: PackedScene = preload("res://scenes/player/shoot.tscn")

@onready var hurt_sound = $Sounds/Hurt_sound
@onready var jump_sound = $Sounds/Jump_sound
@onready var dash_sound = $Sounds/Dash_sound
@onready var shoot_sound = $Sounds/Shoot_sound

@onready var dash_particles = $DashParticles
@onready var rng = RandomNumberGenerator.new()

func _physics_process(delta):
	if not is_dashing:
		animated_sprite_2d.modulate = Color.WHITE
	if is_dead:
		death_ctrl(delta)
	else:
		RUNINFORMATION.run_time += delta
		velocity.y += gravity * delta
		movement_ctrl(delta)
		animation_ctrl()
	apply_camera_shake(delta)
	move_and_slide()

func _input(_event):
	if not is_dead:
		if Input.is_action_just_pressed("A") and a_timer.is_stopped():
			perform_action(GLOBAL.get_card(0))
			a_timer.start()
		elif Input.is_action_just_pressed("B") and b_timer.is_stopped():
			perform_action(GLOBAL.get_card(1))
			b_timer.start()
		elif Input.is_action_just_pressed("X") and x_timer.is_stopped():
			perform_action(GLOBAL.get_card(2))
			x_timer.start()
		elif Input.is_action_just_pressed("Y") and y_timer.is_stopped():
			perform_action(GLOBAL.get_card(3))
			y_timer.start()

func movement_ctrl(delta):
	if is_dashing:
		dash_timer -= delta
		if dash_timer <= 0:
			is_dashing = false
			dash_particles.emitting = false
		if not is_on_floor() and velocity.y >= 0:
			velocity.y = 0
	else:
		velocity.x = SPEED

func animation_ctrl():
	if not is_on_floor():
		if animated_sprite_2d.animation != "jump":
			animated_sprite_2d.play("jump")
	else:
		if animated_sprite_2d.animation != "run":
			animated_sprite_2d.play("run")

func death_ctrl(delta):
	if velocity.x > 0:
		velocity.x -= 1.2
	else:
		velocity.x = 0
		
	velocity.y += gravity * delta
	if animated_sprite_2d.animation != "die":
		animated_sprite_2d.play("die")
		game_over_timer.start()
		shoots_collision_shape_2d.disabled = true

func perform_action(card: String):
	match card:
		"Jump": jump_ctrl()
		"Dash": dash_ctrl()
		"Shoot": shoot_ctrl()
	RUNINFORMATION.cards_used += 1

func jump_ctrl():
	jump_sound.pitch_scale = rng.randf_range(0.8, 1.2)
	jump_sound.play()
	velocity.y = JUMP_VELOCITY

func dash_ctrl():
	dash_particles.emitting = true
	animated_sprite_2d.modulate = Color.KHAKI
	dash_sound.pitch_scale = rng.randf_range(0.8, 1.2)
	dash_sound.play()
	is_dashing = true
	dash_timer = DASH_TIME
	velocity.x = DASH_SPEED

func shoot_ctrl():
	shoot_sound.pitch_scale = rng.randf_range(0.8, 1.2)
	shoot_sound.play()
	var proyectile_instance = proyectile.instantiate()
	proyectile_instance.global_position = global_position
	get_tree().call_group("level", "add_child", proyectile_instance)

func damage_ctrl(damage):
	if health > 0:
		if not is_dashing:
			hurt_sound.play()
			shake_duration = SHAKE_DURATION
			health -= damage
			if health <= 0:
				is_dead = true
				velocity.x = SPEED

func apply_camera_shake(delta):
	if shake_duration > 0:
		shake_duration -= delta
		camera.offset = Vector2(rng.randf_range(-SHAKE_AMOUNT, SHAKE_AMOUNT), rng.randf_range(-SHAKE_AMOUNT, SHAKE_AMOUNT))
	else:
		camera.offset = Vector2.ZERO

func calculate_distance():
	return int(global_position.distance_to(Vector2.ZERO))

func _on_area_2d_area_entered(area):
	if area is Turret_shoot:
		damage_ctrl(1)
		area.queue_free()

func _on_a_timer_timeout():
	a_timer.stop()
	GLOBAL.substitute_card(0)

func _on_b_timer_timeout():
	b_timer.stop()
	GLOBAL.substitute_card(1)

func _on_x_timer_timeout():
	x_timer.stop()
	GLOBAL.substitute_card(2)

func _on_y_timer_timeout():
	y_timer.stop()
	GLOBAL.substitute_card(3)

func _on_game_over_timer_timeout():
	game_over_timer.stop()
	player_died.emit()
