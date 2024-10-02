extends CharacterBody2D

const SPEED = 100
var current_direction = "none"

func _ready():
	$AnimatedSprite2D.play("idle_front")

func _physics_process(delta):
	player_movement(delta)

# Managing how player is moved using arrow keys
func player_movement(delta):
	if Input.is_action_pressed("ui_right"):
		current_direction = "right"
		play_animation(1)
		velocity.x = SPEED
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		current_direction = "left"
		play_animation(1)
		velocity.x = -SPEED
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):
		current_direction = "down"
		play_animation(1)
		velocity.x = 0
		velocity.y = SPEED
	elif Input.is_action_pressed("ui_up"):
		current_direction = "up"
		play_animation(1)
		velocity.x = 0
		velocity.y = -SPEED
	else:
		play_animation(0)
		velocity.x = 0
		velocity.y = 0

	move_and_slide()

# Change direction of the play according to the direction its going or stopped
func play_animation(movement):
	var direction = current_direction
	var animation = $AnimatedSprite2D
	
	if direction == "right":
		animation.flip_h = false
		if movement == 1:
			animation.play("walk_side")
		elif movement == 0:
			animation.play("idle_side")
	if direction == "left":
		animation.flip_h = true
		if movement == 1:
			animation.play("walk_side")
		elif movement == 0:
			animation.play("idle_side")
	
	if direction == "down":
		animation.flip_h = false
		if movement == 1:
			animation.play("walk_front")
		elif movement == 0:
			animation.play("idle_front")
	if direction == "up":
		animation.flip_h = true
		if movement == 1:
			animation.play("walk_back")
		elif movement == 0:
			animation.play("idle_back")
