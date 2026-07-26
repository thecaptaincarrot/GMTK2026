extends Camera3D
class_name ZoomIn

@export var collision_area: CollisionShape3D

var _stored_last_yaw = 0.0

#hacky way to avoid a double trigger of the mouse interaction click to zoom back out
var _frame_delayed = false

func disable_collision():
	collision_area.disabled = true

func enable_collision():
	collision_area.disabled = false

func _process(delta: float) -> void:
	if(Globals.is_zoomed_in() && Input.is_action_just_pressed("mouse_interact")):
		if(_frame_delayed):
			var last_pos = Globals.get_last_position()
			var player = Globals.get_player()
			if(Globals.should_tween):
				player.change_position(last_pos.get_global_position(), Vector3(last_pos.global_rotation.x, _stored_last_yaw, last_pos.global_rotation.z), last_pos.fov)
			else:
				player.set_global_rotation(Vector3(last_pos.global_rotation.x, _stored_last_yaw, last_pos.global_rotation.z))
				player.set_global_position(last_pos.get_global_position())
			Globals.enable_screen_rotation()
			Globals.set_is_zoomed_in(false)
			_frame_delayed = false
			_stored_last_yaw = 0.0
			
		else:
			_frame_delayed = true


func handle_interaction() -> void:
	assert(Globals.get_last_position() != null, "zoom in menu needs a position to return to")
	assert(Globals.get_last_position().valid_clickables.has(self), "last position must be one that gives access to current zoom menu")

	var player: PlayerController = Globals.get_player()
	Globals.hud_controller.set_hud(HudController.HudState.ZOOMED_IN)
	
	_stored_last_yaw = player.global_rotation.y
	
	if(Globals.should_tween):
		player.change_position(self.get_global_position(), self.global_rotation, self.fov)
	else:
		player.set_global_rotation(self.global_rotation)
		player.set_global_position(self.get_global_position())
		player.camera.fov  = self.fov
