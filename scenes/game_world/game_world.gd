extends Node3D

var _player_scene = load("res://scenes/entities/player.tscn")
var _test_room_path ="res://scenes/game_world/rooms/TestRoom.tscn"

var _active_room:GameRoom

var _player:PlayerController

var main_scene:MainScene

func _ready():
	load_room(_test_room_path)
	_player = _player_scene.instantiate()
	var pos = _active_room.set_active_position_node(&"1")
	_player.set_global_position(pos)
	add_child(_player)
	Globals.set_player(_player)

func load_room(path):
	if(_active_room != null):
		_active_room.queue_free()
	#TODO this should be moved into a single loader to optimize later
	_active_room = load(path).instantiate()
	add_child(_active_room)

func _on_right_arrow_pressed() -> void:
	#_player.rotate(Vector3(0, 1, 0), deg_to_rad(-90))
	_player.rotate_screen(-90)

func _on_left_arrow_pressed() -> void:
	#_player.rotate(Vector3(0, 1, 0), deg_to_rad(90))
	_player.rotate_screen(+90)
