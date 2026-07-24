extends Node

@onready var cursor_default_arrow = preload("res://assets/cursor_normal.png")
@onready var cursor_up_arrow = preload("res://assets/cursor_up.png")

func _ready():
	Input.set_custom_mouse_cursor(Globals.cursor_default_arrow)

var message_bus: MessageBus = MessageBus.create()

var _player: PlayerController

func set_player(p: PlayerController) -> void:
	_player = p

func get_player() -> PlayerController:
	return _player
