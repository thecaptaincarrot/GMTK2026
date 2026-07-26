extends Node3D

@onready var crash_timer_label = $Node3D/CrashTimerLabel

var start_ticks_to_crash = 654.43278 * 24 * 60 * 60 * 1000 #In ms, lol

func _physics_process(delta):
	var ticks_to_crash =  start_ticks_to_crash - Globals.time_controller.current_ticks_ms
	var days = floor(ticks_to_crash / (24 * 60 * 60 * 1000))
	
	ticks_to_crash = ticks_to_crash - (days * 24 * 60 * 60 * 1000)
	
	var hours = floor(ticks_to_crash / (60 * 60 * 1000))
	ticks_to_crash = ticks_to_crash - (hours * 60 * 60 * 1000)
	
	var minutes = floor(ticks_to_crash / (60 * 1000))
	ticks_to_crash -= minutes * 60 * 1000
	
	var seconds = floor(ticks_to_crash / 1000)
	
	crash_timer_label.text = "%04d:%02d:%02d:%02d" % [days, hours, minutes, seconds]
