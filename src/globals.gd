extends Node

@onready var cursor_default_arrow = preload("res://assets/cursor_normal.png")
@onready var cursor_up_arrow = preload("res://assets/cursor_up.png")

signal rotation_control_update


var message_bus: MessageBus = MessageBus.create()

var _player: PlayerController

var should_tween:bool = true

var _can_rotate = true

var last_position_node:PlayerPositionOption


func _ready():
	Input.set_custom_mouse_cursor(Globals.cursor_default_arrow)

func set_player(p: PlayerController) -> void:
	_player = p

func get_player() -> PlayerController:
	return _player


func disable_screen_rotation():
	emit_signal("rotation_control_update")
	_can_rotate = false

func enable_screen_rotation():
	emit_signal("rotation_control_update")
	_can_rotate = true

func can_rotate_screen():
	return _can_rotate
