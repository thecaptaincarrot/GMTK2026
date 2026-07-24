extends Node3D

var _player_scene = load("res://scenes/entities/player.tscn")
var _test_room_path ="res://scenes/game_world/rooms/TestRoom.tscn"

@export var screen_rotation_controller := NodePath("HUD/RotationControls")

@export var zoom_controller := NodePath("HUD/ZoomControl")

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
	Globals.rotation_control_update.connect(_rotation_update)
	
	Globals.zoom_change.connect(_zoom_change)

func load_room(path):
	if(_active_room != null):
		_active_room.queue_free()
	#TODO this should be moved into a single loader to optimize later
	_active_room = load(path).instantiate()
	add_child(_active_room)

func _on_right_arrow_pressed() -> void:
	if(Globals.should_tween):
		_player.rotate_screen(-90)
	else:
		_player.rotate(Vector3(0, 1, 0), deg_to_rad(-90))

func _on_left_arrow_pressed() -> void:
	if(Globals.should_tween):
		_player.rotate_screen(90)
	else:
		_player.rotate(Vector3(0, 1, 0), deg_to_rad(90))

func _rotation_update():
	if(Globals.can_rotate_screen()):
		get_node(screen_rotation_controller).visible = true
	else:
		get_node(screen_rotation_controller).visible = false


func _zoom_change():
	if(Globals.is_zoomed_in()):
		get_node(zoom_controller).visible = true
	else:
		get_node(zoom_controller).visible = false


func _on_zoom_back_pressed() -> void:
	pass


func back_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(Globals.cursor_backwards_arrow)


func _back_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(Globals.cursor_default_arrow)


func _on_back_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(Globals.cursor_backwards_arrow)

func _on_back_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(Globals.cursor_default_arrow)
