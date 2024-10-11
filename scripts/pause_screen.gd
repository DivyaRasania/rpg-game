extends Control

var volume_default_position = Vector2(0, 263)
var back_default_position = Vector2(0, 331)
var volume_slider_position = Vector2(0, 258)
var back_slider_position = Vector2(0, 336)

func _ready():
	$VolumeSlider.hide()
	$MuteCheckBox.hide()
	$VolumeButton.position = volume_default_position
	$BackButton.position = back_default_position

func _on_volume_button_pressed():
	$VolumeButton.position = volume_slider_position
	$BackButton.position = back_slider_position
	$VolumeSlider.set_value_no_signal(global.background_music_value)
	$MuteCheckBox.button_pressed = global.background_music_muted
	$VolumeSlider.show()
	$MuteCheckBox.show()

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://scenes/start_screen.tscn")

func _on_volume_slider_value_changed(value):
	global.background_music_value = value
	AudioServer.set_bus_volume_db(0, value)

func _on_mute_check_box_toggled(toggled_on):
	global.background_music_muted = toggled_on
	if toggled_on:
		AudioServer.set_bus_mute(0, true)
	else:
		AudioServer.set_bus_mute(0, false)
