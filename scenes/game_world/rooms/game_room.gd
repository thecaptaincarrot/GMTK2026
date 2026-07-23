extends Node3D
class_name GameRoom

@onready var _position_container = $PlayerPositions

var _hovered_index = null

var _arrow = load("res://assets/cursor_normal.png")
var _up = load("res://assets/cursor_up.png")

signal move_player

func _ready():
	for ppo:PlayerPositionOption in _position_container.get_children():
		ppo.mouse_in_area.connect(_mouse_in)
		ppo.mouse_left_area.connect(_mouse_left)

func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("mouse_interact") && _hovered_index != null):
		var pos = set_active_position_node(_hovered_index)
		emit_signal("move_player", pos)
	
	if(_hovered_index != null):
		Input.set_custom_mouse_cursor(_up)
	else:
		Input.set_custom_mouse_cursor(_arrow)


func set_active_position_node(index:int):
	var result = null
	for opt in _position_container.get_children():
		if(int(opt.name) == index):
			_enable_all_position_colliders()
			opt.enable_collision()
			result = opt.get_global_position()
			break
	return result

func _enable_all_position_colliders():
	for opt in _position_container.get_children():
		opt.enable_collision()

func _mouse_in(index:int):
	_hovered_index = index

func _mouse_left(_index):
	_hovered_index = null
