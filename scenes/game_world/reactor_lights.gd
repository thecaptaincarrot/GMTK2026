extends Node3D


func _ready():
	hide()
	#startup()
	Globals.reactor_started_signal.connect(startup)


func startup():
	var new_tween = create_tween()
	new_tween.tween_callback(show)
	new_tween.tween_callback(AudioPlayer.create_audio.bind("Flicker"))
	new_tween.tween_interval(0.2)
	new_tween.tween_callback(hide)
	new_tween.tween_interval(0.2)
	new_tween.tween_callback(AudioPlayer.create_audio.bind("Flicker"))
	new_tween.tween_callback(show)
	new_tween.tween_interval(0.3)
	new_tween.tween_callback(hide)
	new_tween.tween_interval(1.2)
	new_tween.tween_callback(AudioPlayer.create_audio.bind("Flicker"))
	new_tween.tween_callback(show)
	new_tween.tween_interval(0.2)
	new_tween.tween_callback(hide)
	new_tween.tween_interval(0.2)
	new_tween.tween_callback(AudioPlayer.create_audio.bind("Flicker"))
	new_tween.tween_callback(show)
	new_tween.tween_interval(0.3)
	new_tween.tween_callback(hide)
	new_tween.tween_interval(1.2)
	new_tween.tween_callback(AudioPlayer.create_audio.bind("Flicker"))
	new_tween.tween_callback(show)
