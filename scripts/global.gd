extends Node

var background_music_value = 0
var background_music_muted = false

var current_scene = "level_1"
var change_to_scene = ""
var entered_heal_from = ""
var transition_scene = false

var player_current_attack = false
var player_health = 100

var enemy_health = 100
var enemy_dead = false

var level_1_first_load_in = true
var level_1_player_start_posx = 50
var level_1_player_start_posy = 75
var level_1_player_exit_heal_posx = 160
var level_1_player_exit_heal_posy = 10

var level_2_first_load_in = true
var level_2_player_start_posx = 16
var level_2_player_start_posy = 91
var level_2_player_exit_heal_posx = 358
var level_2_player_exit_heal_posy = 13
