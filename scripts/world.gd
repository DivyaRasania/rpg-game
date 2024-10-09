extends Node2D

func _ready():
	if global.first_load_in:
		$player.position.x = global.player_start_posx
		$player.position.y = global.player_start_posy
	else:
		$player.position.x = global.player_exit_cliffside_posx
		$player.position.y = global.player_exit_cliffside_posy

func _process(delta):
	change_scene()

func _on_cliffside_transition_point_body_entered(body):
	if body.has_method("player"):
		global.transition_scene = true

func _on_cliffside_transition_point_body_exited(body):
	if body.has_method("player"):
		global.transition_scene = false

func change_scene():
	if global.transition_scene and global.current_scene == "world":
		get_tree().change_scene_to_file("res://scenes/cliff_side.tscn")
		global.first_load_in = false
		global.current_scene = "cliff_side"
