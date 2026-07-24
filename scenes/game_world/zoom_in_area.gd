extends Camera3D

class_name ZoomIn

@export var collision_area: CollisionShape3D

var _zoom_active:bool = false

#hacky way to avoid a double trigger of the mouse interaction click to zoom back out
var _frame_delayed = false

func disable_collision():
	collision_area.disabled = true

func enable_collision():
	collision_area.disabled = false

func _process(delta: float) -> void:
	if(_zoom_active && Input.is_action_just_pressed("mouse_interact")):
		if(_frame_delayed):
			var last_pos = Globals.get_last_position()
			var player = Globals.get_player()
			if(Globals.should_tween):
				player.change_position(last_pos.get_position(), Vector2(last_pos.global_rotation.x, last_pos.global_rotation.z))
			else:
				player.set_global_rotation(Vector3(last_pos.rotation.x, last_pos.rotation.y, last_pos.rotation.z))
				player.set_global_position(last_pos.get_position())
			Globals.enable_screen_rotation()
			_zoom_active = false
			_frame_delayed = false
			
		else:
			_frame_delayed = true


func handle_interaction() -> void:
	if(!_zoom_active):
		if(Globals.get_last_position() != null):
			if(!Globals.get_last_position().valid_neighbors.has(self)):
				return
		var player = Globals.get_player()
		Globals.disable_screen_rotation()
		
		if(Globals.should_tween):
			player.change_position(self.get_position(), Vector2(self.global_rotation.x, self.global_rotation.z))
		else:
			player.set_global_rotation(Vector3(self.rotation.x, player.rotation.y, self.rotation.z))
			player.set_global_position(self.get_position())
		
		_zoom_active = true
