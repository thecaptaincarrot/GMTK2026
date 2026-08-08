extends Node

class_name HudController

enum HudState { HUDLESS, EXPLORE, ZOOMED_IN, READING_NOTE }

const DEFAULT_HUDS: Dictionary[HudState, PackedScene] = {
	HudState.EXPLORE: preload("res://scenes/huds/hud_explore.tscn"),
	HudState.ZOOMED_IN: preload("res://scenes/huds/hud_zoom_in.tscn"),
	HudState.READING_NOTE: preload("res://scenes/huds/hud_note.tscn"),
}

var huds_state: Dictionary[HudState, PackedScene]
var current_hud_state: HudState = HudState.HUDLESS
var current_hud_scene: HudBase = null

var previous_hud_state : HudState = HudState.HUDLESS

func _init(_huds_state: Dictionary[HudState, PackedScene] = DEFAULT_HUDS) -> void:
	self.huds_state = _huds_state

func _ready() -> void:
	# Connect signals
	SignalBus.note_inspect.connect(_on_note_inspect)
	SignalBus.zoom_in.connect(_on_zoom_in)
	SignalBus.entedered_position_node.connect(_on_entedered_position_node)
	SignalBus.open_binder.connect(_on_open_binder)

func set_hud(state: HudState):
	if state == self.current_hud_state:
		return
	if current_hud_scene:
		current_hud_scene.queue_free()
		current_hud_scene = null
	var instance := huds_state[state].instantiate() as HudBase
	add_child(instance)
	previous_hud_state = current_hud_state
	current_hud_scene = instance
	current_hud_state = state


func revert_hud_state():
	set_hud(previous_hud_state)


func _on_note_inspect(note_data) -> void:
	Globals.set_active_note(note_data)
	self.set_hud(HudController.HudState.READING_NOTE)


func _on_zoom_in() -> void:
	self.set_hud(HudController.HudState.ZOOMED_IN)


func _on_entedered_position_node() -> void:
	self.set_hud(HudController.HudState.EXPLORE)


func _on_open_binder() -> void:
	Globals.open_binder()
	self.set_hud(HudController.HudState.READING_NOTE)