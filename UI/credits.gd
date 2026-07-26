extends Control

@export var scroll_speed = 128.0

var main_scene



func _process(delta: float) -> void:
	$VBoxContainer.position.y -= delta * scroll_speed
	
	if $VBoxContainer.position.y < -2700:
		main_scene.show_main_menu()


func _on_back_button_pressed() -> void:
	main_scene.show_main_menu()
