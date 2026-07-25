extends Node3D
class_name GameRoom

@onready var _room_container = $Rooms


func _ready():
	for player_position: PlayerPositionOption in get_all_player_positions():
		player_position.game_room  = self


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
