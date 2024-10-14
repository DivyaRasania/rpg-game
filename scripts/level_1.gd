extends Node2D

func _ready():
	if global.level_1_first_load_in:
		$player.position.x = global.level_1_player_start_posx
		$player.position.y = global.level_1_player_start_posy
	else:
		$player.position.x = global.level_1_player_exit_heal_posx
		$player.position.y = global.level_1_player_exit_heal_posy
		
		if global.enemy_dead:
			$enemy.queue_free()

func _process(delta):
	change_scene()

func _on_heal_entry_body_entered(body):
	if body.has_method("player"):
		global.transition_scene = true
		global.change_to_scene = "hidden_heal"

func _on_heal_entry_body_exited(body):
	if body.has_method("player"):
		global.transition_scene = false

func _on_level_2_entry_body_entered(body):
	if body.has_method("player"):
		global.transition_scene = true
		global.change_to_scene = "level_2"
		
func _on_level_2_entry_body_exited(body):
	if body.has_method("player"):
		global.transition_scene = false

func change_scene():
	if global.transition_scene:
		if global.change_to_scene == "hidden_heal":
			global.entered_heal_from = "level_1"
			get_tree().change_scene_to_file("res://scenes/hidden_heal.tscn")
			global.current_scene = "hidden_heal"
			global.level_1_first_load_in = false
		elif global.change_to_scene == "level_2":
			get_tree().change_scene_to_file("res://scenes/level_2.tscn")
			global.current_scene = "level_2"
			global.level_1_first_load_in = false
		else:
			global.transition_scene = false
