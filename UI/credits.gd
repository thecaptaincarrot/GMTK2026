extends Control

@export var scroll_speed = 1.0

var main_scene

func _process(delta: float) -> void:
	var credits_height = get_global_rect().end.y
	var pos = get_screen_position()
	var new_pos = pos + (Vector2(0, -1) * scroll_speed * 10 * delta)
	var window_size = get_viewport().get_visible_rect().size
	var height = (credits_height - (window_size.y / 2))
	if(height > 0):
		set_position(new_pos)


func _on_back_button_pressed() -> void:
	main_scene.show_main_menu()
