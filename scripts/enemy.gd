extends CharacterBody2D

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
	
	if player_chase:
		position += (player.position - position) / speed
		$AnimatedSprite2D.play("running_side")
		
		if (player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.play("idle_front")

func _on_detection_area_body_entered(body):
	player = body
	player_chase = true

func _on_detection_area_body_exited(body):
	player = null
	player_chase = false

func enemy():
	pass

func _on_enemy_hitbox_body_entered(body):
	if body.has_method("player"):
		player_in_attack_zone = true

func _on_enemy_hitbox_body_exited(body):
	if body.has_method("player"):
		player_in_attack_zone = false

func deal_with_damage():
	if player_in_attack_zone and global.player_current_attack:
		if can_take_damage:
			$take_damage_cooldown.start()
			can_take_damage = false
			health -= 20
			print("slime health = ", health)
			if health <= 0:
				self.queue_free()

func _on_take_damage_cooldown_timeout():
	can_take_damage = true
