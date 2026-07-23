extends Node
class_name MainScene

var _main_menu_scene = load("res://UI/main_menu.tscn")
var _credits_scene = load("res://UI/credits.tscn")
var _game_scene = load("res://scenes/game_world/GameWorld.tscn")

var _active_scene = null

func _ready():
	show_main_menu()

func show_main_menu():
	if(_active_scene != null):
		_active_scene.queue_free()
	_active_scene = _main_menu_scene.instantiate()
	_active_scene.main_scene = self
	add_child(_active_scene)

func show_credits():
	if(_active_scene != null):
		_active_scene.queue_free()
	_active_scene = _credits_scene.instantiate()
	_active_scene.main_scene = self
	add_child(_active_scene)

func show_game_scene():
	if(_active_scene != null):
		_active_scene.queue_free()
	_active_scene = _game_scene.instantiate()
	_active_scene.main_scene = self
	add_child(_active_scene)
