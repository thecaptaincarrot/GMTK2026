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
