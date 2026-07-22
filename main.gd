extends Node

var _main_menu_scene = load("res://UI/main_menu.tscn")

var _active_scene = null

func show_main_menu():
	if(_active_scene != null):
		_active_scene.queue_free()

func show_credits():
	if(_active_scene != null):
		_active_scene.queue_free()

func show_game_scene():
	if(_active_scene != null):
		_active_scene.queue_free()
