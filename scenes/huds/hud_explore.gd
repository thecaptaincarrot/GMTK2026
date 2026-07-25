extends HudBase

class_name HudExplore

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