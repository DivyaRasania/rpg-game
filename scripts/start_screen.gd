extends Control

func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")

func _on_options_pressed():
	get_tree().change_scene_to_file("res://scenes/options_menu.tscn")

func _on_how_to_play_pressed():
	get_tree().change_scene_to_file("res://scenes/how_to_play.tscn")

func _on_exit_pressed():
	get_tree().quit()
