extends Node2D

func _process(delta):
	change_scene()

func _on_exit_point_body_entered(body):
	if body.has_method("player"):
		global.transition_scene = true

func _on_exit_point_body_exited(body):
	if body.has_method("player"):
		global.transition_scene = false

func change_scene():
	if global.transition_scene:
		if global.entered_heal_from == "level_1":
			get_tree().change_scene_to_file("res://scenes/level_1.tscn")
			global.current_scene = "level_1"
		elif global.entered_heal_from == "level_2":
			get_tree().change_scene_to_file("res://scenes/level_2.tscn")
			global.current_scene = "level_2"

func _on_heal_area_body_entered(body):
	if body.has_method("player"):
		global.player_health = 100
		$AnimationPlayer.play("taken")
