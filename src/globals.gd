extends Node

@onready var cursor_default_arrow = preload("res://assets/cursor_normal.png")
@onready var cursor_interact = preload("res://assets/cursor_interact.png")
@onready var cursor_up_arrow = preload("res://assets/cursor_up.png")
@onready var cursor_down_arrow = preload("res://assets/cursor_down.png")
@onready var cursor_left_arrow = preload("res://assets/cursor_left.png")
@onready var cursor_right_arrow = preload("res://assets/cursor_right.png")
@onready var cursor_backwards_arrow = preload("res://assets/cursor_back.png")

@onready var active_material = load("res://assets/Materials/RedEmission/RedEmissionMaterial.tres")
@onready var half_active_material = load("res://assets/Materials/RedEmission/HalfEmissionMaterial.tres")
@onready var inactive_material = load("res://assets/Materials/RedEmission/RedOffMaterial.tres")
@onready var console_off_material = load("res://scenes/entities/Cockpit/ConsoleOffMaterial.tres")
@onready var console_on_material = load("res://scenes/entities/Cockpit/ConsoleOnMaterial.tres")

signal rotation_control_update
signal zoom_change

var message_bus: MessageBus = MessageBus.create()

var _player: PlayerController
var hud_controller: HudController
var time_controller: TimeController

var should_tween:bool = true

var _can_rotate = true

var _last_position_node:PlayerPositionOption

var _last_zoom_in_node : ZoomIn
var _sub_zoom_in = false

var _active_text_pages_front: Array[Texture2D]
var _active_text_pages_back: Array[Texture2D]
var _active_note_pages: Array[Texture2D]

var _zoomed_in:bool = false

var reactor_started = false
signal reactor_started_signal

signal disable_HUD_buttons
signal enable_HUD_buttons

func _ready():
	Input.set_custom_mouse_cursor(Globals.cursor_default_arrow)

	# Hud Controller
	hud_controller = HudController.new()
	add_child(hud_controller)

	# Time Controller
	time_controller = TimeController.new()
	add_child(time_controller)


func set_player(p: PlayerController) -> void:
	_player = p

func get_player() -> PlayerController:
	return _player

func set_is_zoomed_in(value:bool):
	_zoomed_in = value

func is_zoomed_in():
	return _zoomed_in


func is_sub_zoomed_in():
	return _sub_zoom_in


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
func set_active_note(note_pages: Array[Texture2D], text_pages_front : Array[Texture2D] = [], text_pages_back : Array[Texture2D] = []) -> void:
	_active_note_pages = note_pages
	_active_text_pages_front = text_pages_front
	_active_text_pages_back = text_pages_back

func get_active_note() -> Array[Texture2D]:
	return _active_note_pages

func get_active_text_pages_front() -> Array[Texture2D]:
	return _active_text_pages_front

func get_active_text_pages_back() -> Array[Texture2D]:
	return _active_text_pages_back

var notes_collected = []
var  binder_collected = false

@onready var binder_cover = load("res://assets/notes/BinderPages/binder0.png")
@onready var binder_empty = load("res://assets/notes/BinderPages/binder01.png")
@onready var binder_first = load("res://assets/notes/BinderPages/binder02.png")
@onready var binder_middle = load("res://assets/notes/BinderPages/binder03.png")
@onready var binder_last = load("res://assets/notes/BinderPages/binder04.png")

@onready var one_front = load("res://assets/notes/BinderPages/01first.png")
@onready var one_back = load("res://assets/notes/BinderPages/01second.png")
@onready var two_front = load("res://assets/notes/BinderPages/02first.png")
@onready var two_back = load("res://assets/notes/BinderPages/02second.png")
@onready var three_front = load("res://assets/notes/BinderPages/03first.png")
@onready var three_back = load("res://assets/notes/BinderPages/03second.png")
@onready var four_front = load("res://assets/notes/BinderPages/04first.png")
@onready var four_back = load("res://assets/notes/BinderPages/04second.png")

func open_binder():
	set_active_note(get_binder_pages(), get_binder_text_front(), get_binder_text_back())
	hud_controller.set_hud(HudController.HudState.READING_NOTE)


func get_binder_text_front():
	var page_textures : Array[Texture2D]
	
	if notes_collected.has(1):
		page_textures.append(one_front)
	if notes_collected.has(2):
		page_textures.append(two_front)
	if notes_collected.has(3):
		page_textures.append(three_front)
	if notes_collected.has(4):
		page_textures.append(four_front)
	
	return page_textures


func get_binder_text_back():
	var page_textures : Array[Texture2D]
	
	if notes_collected.has(1):
		page_textures.append(one_back)
	if notes_collected.has(2):
		page_textures.append(two_back)
	if notes_collected.has(3):
		page_textures.append(three_back)
	if notes_collected.has(4):
		page_textures.append(four_back)
	
	return page_textures


func get_binder_pages():
	var binder_textures : Array[Texture2D]
	binder_textures.append(binder_cover)
	if notes_collected.size() == 0:
		binder_textures.append(binder_empty)
	else:
		binder_textures.append(binder_first)
		if notes_collected.size() >= 2:
			binder_textures.append(binder_middle)
		if notes_collected.size() >= 3:
			binder_textures.append(binder_middle)
		if notes_collected.size() >= 4:
			binder_textures.append(binder_middle)
		binder_textures.append(binder_last)
	return binder_textures
