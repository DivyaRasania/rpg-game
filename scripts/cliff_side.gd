extends Node2D

func _process(delta):
	change_scene()

func _on_cliffside_exit_point_body_entered(body):
	if body.has_method("player"):
		global.transition_scene = true

func _on_cliffside_exit_point_body_exited(body):
	if body.has_method("player"):
		global.transition_scene = false

func change_scene():
	if global.transition_scene and global.current_scene == "cliff_side":
		get_tree().change_scene_to_file("res://scenes/world.tscn")
		global.current_scene = "world"
