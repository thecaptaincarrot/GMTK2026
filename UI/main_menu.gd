extends Control

var main_scene


func _on_credits_pressed() -> void:
	main_scene.show_credits()


func _on_play_pressed() -> void:
	main_scene.show_game_scene()
	Globals.time_controller.start(int(Time.get_unix_time_from_system() * 1000))
