extends Node3D
class_name GameRoom

@onready var _position_container = $PlayerPositions

func set_active_position_node(name:StringName):
	var result = null
	for opt in _position_container.get_children():
		if(opt.name == name):
			_enable_all_position_colliders()
			opt.enable_collision()
			result = opt.get_global_position()
			break
	return result

func _enable_all_position_colliders():
	for opt in _position_container.get_children():
		opt.enable_collision()
