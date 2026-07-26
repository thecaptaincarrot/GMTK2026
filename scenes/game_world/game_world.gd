extends Node3D
class_name GameWorld

var _player_scene = load("res://scenes/entities/player.tscn")
var _test_room_path ="res://scenes/game_world/rooms/TestRoom.tscn"
var _ship_world_path = "res://scenes/game_world/ship_world.tscn"

@export var screen_rotation_controller := NodePath("HUD/RotationControls")

@export var zoom_controller := NodePath("HUD/ZoomControl")

var _active_room:GameRoom

var _player:PlayerController

var main_scene:MainScene

func _ready():
	AudioPlayer.game_node  = self
	
	load_room(_ship_world_path)
	_player = _player_scene.instantiate()
	
	_player.game_room = _active_room
	add_child(_player)
	
	Globals.set_player(_player)
	
	var starting_player_position_option = _active_room.get_position_node(&"Airlock0")
	starting_player_position_option.move_player_to_position(true)
	_player.rotation.y = PI/2.0 #I don't think hard setting this is a good idea, but here we are
	
	Globals.hud_controller.set_hud(HudController.HudState.EXPLORE)


func load_room(path):
	if(_active_room != null):
		_active_room.queue_free()
	#TODO this should be moved into a single loader to optimize later
	_active_room = load(path).instantiate()
	if _player:
		_player.game_room = _active_room
	add_child(_active_room)


func back_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(Globals.cursor_backwards_arrow)

func _back_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(Globals.cursor_default_arrow)


func _on_back_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(Globals.cursor_backwards_arrow)

func _on_back_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(Globals.cursor_default_arrow)
