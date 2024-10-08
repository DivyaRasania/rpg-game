extends CharacterBody2D

const SPEED = 100

var current_direction = "none"
var enemy_in_attack_range = false
var enemy_attack_cooldown = true
var player_alive = true
var health = 100
var attack_in_progress = false

func _ready():
	$AnimatedSprite2D.play("idle_front")

func _physics_process(delta):
	player_movement(delta)
	enemy_attack()
	attack()
	current_camera()

func player_movement(delta):
	if Input.is_action_pressed("move_right"):
		current_direction = "right"
		play_animation(1)
		velocity.x = SPEED
		velocity.y = 0
	elif Input.is_action_pressed("move_left"):
		current_direction = "left"
		play_animation(1)
		velocity.x = -SPEED
		velocity.y = 0
	elif Input.is_action_pressed("move_down"):
		current_direction = "down"
		play_animation(1)
		velocity.x = 0
		velocity.y = SPEED
	elif Input.is_action_pressed("move_up"):
		current_direction = "up"
		play_animation(1)
		velocity.x = 0
		velocity.y = -SPEED
	else:
		play_animation(0)
		velocity.x = 0
		velocity.y = 0

	move_and_slide()

func play_animation(movement):
	var direction = current_direction
	var animation = $AnimatedSprite2D

	if direction == "right":
		animation.flip_h = false
		if movement == 1:
			animation.play("walk_side")
		elif movement == 0:
			if attack_in_progress == false:
				animation.play("idle_side")

	if direction == "left":
		animation.flip_h = true
		if movement == 1:
			animation.play("walk_side")
		elif movement == 0:
			if attack_in_progress == false:
				animation.play("idle_side")
	
	if direction == "down":
		animation.flip_h = false
		if movement == 1:
			animation.play("walk_front")
		elif movement == 0:
			if attack_in_progress == false:
				animation.play("idle_front")

	if direction == "up":
		animation.flip_h = true
		if movement == 1:
			animation.play("walk_back")
		elif movement == 0:
			if attack_in_progress == false:
				animation.play("idle_back")

func player():
	pass

func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_in_attack_range = true

func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_in_attack_range = false

func enemy_attack():
	if enemy_in_attack_range and enemy_attack_cooldown:
		health -= 20
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		print("player health = ", health)
		if health <= 0:
			player_alive = false
			self.queue_free()

func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true

func attack():
	var direction = current_direction
	
	if Input.is_action_just_pressed("attack"):
		global.player_current_attack = true
		attack_in_progress = true
		
		if direction == "right":
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("attack_side")
			$deal_attack_timer.start()

		if direction == "left":
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("attack_side")
			$deal_attack_timer.start()

		if direction == "down":
			$AnimatedSprite2D.play("attack_front")
			$deal_attack_timer.start()

		if direction == "up":
			$AnimatedSprite2D.play("attack_back")
			$deal_attack_timer.start()

func _on_deal_attack_timer_timeout():
	$deal_attack_timer.stop()
	global.player_current_attack = false
	attack_in_progress = false

func current_camera():
	if global.current_scene == "world":
		$world_camera.enabled = true
		$cliffside_camera.enabled = false
	elif global.current_scene == "cliff_side":
		$world_camera.enabled = false
		$cliffside_camera.enabled = true
