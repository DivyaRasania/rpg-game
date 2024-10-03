extends CharacterBody2D

# Variables
var speed = 50
var player_chase = false
var player = null
var health = 80
var player_in_attack_zone = false
var can_take_damage = true

func _ready():
	$AnimatedSprite2D.play("idle_front")

func _physics_process(delta):
	deal_with_damage()
	
	# Chasing player if it enters slimes detection_area(Area2D)
	if player_chase:
		position += (player.position - position) / speed
		$AnimatedSprite2D.play("running_side")
		
		if (player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
		
	#if player_chase:
		#position.x += (player.position.x - position.x) / speed
		#position.y += (player.position.y - position.y) / speed
		#
		## Flip slime according to players position
		#if (player.position.x - position.x) < 0:
			#$AnimatedSprite2D.play("running_side")
		#elif (player.position.x - position.x) > 0:
			#$AnimatedSprite2D.flip_h = true
		#elif (player.position.y - position.y) < 0:
			#$AnimatedSprite2D.play("running_back")
		#elif (player.position.y - position.y) > 0:
			#$AnimatedSprite2D.play("running_front")
		#else:
			#$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.play("idle_front")

# If player enters detection_area(Area2D), player_chase changes to true and if exits it changes to false
func _on_detection_area_body_entered(body):
	player = body
	player_chase = true

func _on_detection_area_body_exited(body):
	player = null
	player_chase = false

func enemy():
	pass

# Checks if player entered the hitbox area or not and if it does, player_in_attack zone is set to true and if it exits that are it changes back to false
func _on_enemy_hitbox_body_entered(body):
	if body.has_method("player"):
		player_in_attack_zone = true

func _on_enemy_hitbox_body_exited(body):
	if body.has_method("player"):
		player_in_attack_zone = false

# If player is in attack zone, player can attack and slime can take damage, slime takes damage
func deal_with_damage():
	if player_in_attack_zone and global.player_current_attack:
		if can_take_damage:
			# adding a cool down to take damage so player cant spam attack to kill slime instantly
			$take_damage_cooldown.start()
			can_take_damage = false
			health -= 20
			print("slime health = ", health)
			# If slimes health is <= 0 it removes itself from scene
			if health <= 0:
				self.queue_free()

func _on_take_damage_cooldown_timeout():
	can_take_damage = true
