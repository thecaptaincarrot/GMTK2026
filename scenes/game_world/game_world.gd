extends Node3D

var _player_scene = load("res://scenes/entities/player.tscn")
var _test_room_path ="res://scenes/game_world/rooms/TestRoom.tscn"

var _arrow = load("res://assets/cursor_normal.png")

var _active_room:GameRoom
var _player:PlayerController

var main_scene:MainScene


func _ready():
	Input.set_custom_mouse_cursor(_arrow)
	load_room(_test_room_path)
	_player = _player_scene.instantiate()
	var pos = _active_room.set_active_position_node(1)
	_player.set_global_position(pos)
	add_child(_player)

func load_room(path):
	if(_active_room != null):
		_active_room.move_player.disconnect(_move_player)
		_active_room.queue_free()
	#this should be moved into a single loader to optimize later
	_active_room = load(path).instantiate()
	_active_room.move_player.connect(_move_player)
	add_child(_active_room)

func _move_player(pos:Vector3):
	_player.set_global_position(pos)
