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

@onready var black_hole_rotator = $BlackHoleRotator
var black_hole_target_rotation = 0.0
@export var black_hole_rotation_speed = PI/8
signal rotation_complete
var rotation_in_progress = false

signal rotation_updated

@onready var debug_menu: CanvasLayer = $DebugInfo

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
	if OS.is_debug_build():
		print("Running Debug Build")
		debug_menu.visible = true
	else:
		print("Running Release Build")

func _physics_process(delta):
	if abs(black_hole_target_rotation - black_hole_rotator.rotation.z) > PI/256:
		if black_hole_rotator.rotation.z > black_hole_target_rotation:
			black_hole_rotator.rotation.z -= delta * black_hole_rotation_speed
		else:
			black_hole_rotator.rotation.z += delta * black_hole_rotation_speed
		rotation_updated.emit(black_hole_rotator.rotation.z)
	else:
		if rotation_in_progress:
			rotation_complete.emit()
			rotation_in_progress = false

func load_room(path):
	if(_active_room != null):
		_active_room.queue_free()
	#TODO this should be moved into a single loader to optimize later
	_active_room = load(path).instantiate()
	_active_room.game_world = self
	if _player:
		_player.game_room = _active_room
	_active_room.game_ended.connect(main_scene.show_ending)
	add_child(_active_room)


func back_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(Globals.cursor_backwards_arrow)

func _back_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(Globals.cursor_default_arrow)


func _on_back_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(Globals.cursor_backwards_arrow)

func _on_back_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(Globals.cursor_default_arrow)


func rotate_black_hole(new_target):
	black_hole_target_rotation = new_target
	rotation_in_progress = true
