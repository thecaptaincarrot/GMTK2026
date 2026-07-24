extends Node3D
class_name GameRoom

@onready var _position_container = $PlayerPositions

func set_active_position_node(pos_name:StringName):
	var result = null
	for opt:PlayerPositionOption in _position_container.get_children():
		if(opt.name == pos_name):
			disable_all_position_colliders()
			opt.enable_collision()
			result = opt.get_global_position()
			Globals.last_position_node = opt
			opt.enable_neighbors()
			break
	return result

func enable_all_position_colliders():
	for opt in _position_container.get_children():
		opt.enable_collision()

func disable_all_position_colliders():
	for opt in _position_container.get_children():
		opt.disable_collision()
