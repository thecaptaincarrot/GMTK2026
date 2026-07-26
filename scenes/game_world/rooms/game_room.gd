extends Node3D
class_name GameRoom

@onready var _room_container = $Rooms

signal disable_cockpit

signal rotate_black_hole
signal game_ended

var game_world : GameWorld

@export var control_wheel : Node3D

func _ready():
	for player_position: PlayerPositionOption in get_all_player_positions():
		player_position.game_room  = self
	
	for zoom_in : ZoomIn in get_all_zoom_in():
		zoom_in.game_room = self
	
	game_world.rotation_complete.connect(control_wheel.rotation_complete)
	control_wheel.new_black_hole_rotation.connect(game_world.rotate_black_hole)


func set_active_position_node(pos_name:StringName):
	var result = null
	for opt:PlayerPositionOption in get_all_player_positions():
		if(opt.name == pos_name):
			disable_all_position_colliders()
			
			opt.enable_collision()
			
			result = opt.get_global_position()
			
			Globals.set_last_position(opt)
			
			opt.enable_neighbors()
			
			break
	return result


func get_position_node(pos_name:StringName):
	var result = null
	for opt:PlayerPositionOption in get_all_player_positions():
		if(opt.name == pos_name):
			result =  opt
	return result


func disable_all_clickables():
	Globals.disable_HUD_buttons.emit()
	for opt in get_all_player_positions():
		opt.disable_collision()
	for opt in get_all_interactables():
		opt.disable_collision()
	for opt in get_all_notes():
		opt.disable_collision()
	for opt in get_all_zoom_in():
		opt.disable_collision()
	disable_cockpit.emit()


func enable_all_position_colliders():
	for opt in get_all_player_positions():
		opt.enable_collision()

func disable_all_position_colliders():
	for opt in get_all_player_positions():
		opt.disable_collision()


func get_all_player_positions() ->  Array[PlayerPositionOption]:
	var player_positions : Array[PlayerPositionOption]
	for room_node in _room_container.get_children():
		for player_position in room_node.get_node("PlayerPositions").get_children():
			if player_position is PlayerPositionOption:
				player_positions.append(player_position)
	return player_positions


func get_all_interactables() -> Array[Interactable]: 
	var interactables : Array[Interactable]
	for room_node in _room_container.get_children():
		for interactee in room_node.get_node("Interactables").get_children():
			if interactee is Interactee:
				if interactee.get_interactable() is Interactable:
					interactables.append(interactee.get_interactable())
	return interactables


func get_all_notes() -> Array[Note]:
	var notes : Array[Note]
	for room_node in _room_container.get_children():
		for interactee in room_node.get_node("Interactables").get_children():
			if interactee is Note:
				notes.append(interactee)
	return notes


func get_all_zoom_in() -> Array[ZoomIn]:
	var zoom_ins : Array[ZoomIn]
	for room_node in _room_container.get_children():
		for zoom_in in room_node.get_node("PlayerPositions").get_children():
			if zoom_in is ZoomIn:
				zoom_ins.append(zoom_in)
	return zoom_ins
