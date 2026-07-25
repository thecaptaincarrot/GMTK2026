extends Node

@onready var cursor_default_arrow = preload("res://assets/cursor_normal.png")
@onready var cursor_interact = preload("res://assets/cursor_interact.png")
@onready var cursor_up_arrow = preload("res://assets/cursor_up.png")
@onready var cursor_down_arrow = preload("res://assets/cursor_down.png")
@onready var cursor_left_arrow = preload("res://assets/cursor_left.png")
@onready var cursor_right_arrow = preload("res://assets/cursor_right.png")
@onready var cursor_backwards_arrow = preload("res://assets/cursor_back.png")

signal rotation_control_update
signal zoom_change

var message_bus: MessageBus = MessageBus.create()

var _player: PlayerController
var hud_controller: HudController

var should_tween:bool = true

var _can_rotate = true

var _last_position_node:PlayerPositionOption
var _active_note_pages: Array[Texture2D]

var _zoomed_in:bool = false

func _ready():
	Input.set_custom_mouse_cursor(Globals.cursor_default_arrow)
	hud_controller = HudController.new()
	add_child(hud_controller)

func set_player(p: PlayerController) -> void:
	_player = p

func get_player() -> PlayerController:
	return _player

func set_is_zoomed_in(value:bool):
	_zoomed_in = false
	emit_signal("zoom_changed")

func is_zoomed_in():
	return _zoomed_in
	

func set_last_position(node:PlayerPositionOption):
	_last_position_node = node

func get_last_position() -> PlayerPositionOption:
	return _last_position_node

func disable_screen_rotation():
	_can_rotate = false
	emit_signal("rotation_control_update")

func enable_screen_rotation():
	_can_rotate = true
	emit_signal("rotation_control_update")

func can_rotate_screen():
	return _can_rotate

# Notes
func set_active_note(note_pages: Array[Texture2D]) -> void:
	_active_note_pages = note_pages

func get_active_note() -> Array[Texture2D]:
	return _active_note_pages
