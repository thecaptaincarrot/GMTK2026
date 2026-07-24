extends Node

@onready var cursor_default_arrow = preload("res://assets/cursor_normal.png")
@onready var cursor_up_arrow = preload("res://assets/cursor_up.png")


var message_bus: MessageBus = MessageBus.create()

var _player: PlayerController

var should_tween:bool = true

var last_position_node:PlayerPositionOption


func _ready():
	Input.set_custom_mouse_cursor(Globals.cursor_default_arrow)

func set_player(p: PlayerController) -> void:
	_player = p

func get_player() -> PlayerController:
	return _player
