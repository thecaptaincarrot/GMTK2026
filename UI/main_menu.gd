extends Control

var main_scene

func _ready() -> void:
	MusicManager.setSong("TRACK2")

func _on_credits_pressed() -> void:
	# no reverb in credits 
	AudioManager.REVERB_SETUP_VECTOR = Vector4(0, 0, 0, 0)
	AudioManager.QUEUED_SETUP_VECTOR = Vector4(0, 0, 0, 0)
	MusicManager.setSong("CREDITS")
	main_scene.show_credits()


func _on_play_pressed() -> void:
	MusicManager.setSong("TRACK1")
	main_scene.show_game_scene()
	Globals.time_controller.start(int(Time.get_unix_time_from_system() * 1000))


func _on_check_button_toggled(toggled_on):
	Globals.should_tween = toggled_on
	if toggled_on:
		$CheckButton.text = "Animated Camera Transitions Enabled"
	else:
		$CheckButton.text = "Animated Camera Transitions Disabled"
