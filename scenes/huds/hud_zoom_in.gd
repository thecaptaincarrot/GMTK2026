extends HudBase

class_name HudZoomIn

func _on_zoom_back_pressed() -> void:
	Globals.hud_controller.set_hud(HudController.HudState.EXPLORE)
	var last_pos = Globals.get_last_position()
	last_pos.handle_interaction()
