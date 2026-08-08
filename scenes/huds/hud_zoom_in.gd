extends HudBase
class_name HudZoomIn

@onready var ZoomBackButton = $ZoomControl/ZoomBack

func _ready():
	Globals.disable_HUD_buttons.connect(ZoomBackButton.set_disabled.bind(true))
	Globals.enable_HUD_buttons.connect(ZoomBackButton.set_disabled.bind(false))


func _on_zoom_back_pressed() -> void:
	if Globals.is_sub_zoomed_in():
		Globals._last_zoom_in_node.move_player_to_position(true)
	else:
		var last_pos = Globals.get_last_position()
		last_pos.handle_interaction()
		Globals._last_zoom_in_node = null


func _on_zoom_back_mouse_entered():
	Input.set_custom_mouse_cursor(Globals.cursor_down_arrow)


func _on_zoom_back_mouse_exited():
	Input.set_custom_mouse_cursor(Globals.cursor_default_arrow)
