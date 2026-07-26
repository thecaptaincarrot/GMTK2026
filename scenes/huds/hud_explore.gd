extends HudBase
class_name HudExplore

@onready var RightArrowButton = $RotationControls/RightArrow
@onready var LeftArrowButton = $RotationControls/LeftArrow

func _ready():
	Globals.disable_HUD_buttons.connect(RightArrowButton.set_disabled.bind(true))
	Globals.enable_HUD_buttons.connect(RightArrowButton.set_disabled.bind(false))
	Globals.disable_HUD_buttons.connect(LeftArrowButton.set_disabled.bind(true))
	Globals.enable_HUD_buttons.connect(LeftArrowButton.set_disabled.bind(false))

func _on_right_arrow_pressed() -> void:
	var player = Globals.get_player()
	if(Globals.should_tween):
		player.rotate_screen(-90)
	else:
		player.rotate(Vector3(0, 1, 0), deg_to_rad(-90))

func _on_left_arrow_pressed() -> void:
	var player = Globals.get_player()
	if(Globals.should_tween):
		player.rotate_screen(90)
	else:
		player.rotate(Vector3(0, 1, 0), deg_to_rad(90))


func _on_right_arrow_mouse_entered():
	Input.set_custom_mouse_cursor(Globals.cursor_right_arrow)


func _on_right_arrow_mouse_exited():
	Input.set_custom_mouse_cursor(Globals.cursor_default_arrow)


func _on_left_arrow_mouse_entered():
	Input.set_custom_mouse_cursor(Globals.cursor_left_arrow)


func _on_left_arrow_mouse_exited():
	Input.set_custom_mouse_cursor(Globals.cursor_default_arrow)
