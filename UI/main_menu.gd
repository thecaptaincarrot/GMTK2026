extends Control

var main_scene


func _on_credits_pressed() -> void:
	main_scene.show_credits()


func _on_play_pressed() -> void:
	main_scene.show_game_scene()
