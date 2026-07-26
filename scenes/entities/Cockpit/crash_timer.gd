extends Node3D

@onready var crash_timer_label = $Node3D/CrashTimerLabel

var start_ticks_to_crash = 654.43278 * 24 * 60 * 60 * 1000 #In ms, lol

var rapid = false
var rapid_scalar = 0.0

func _physics_process(delta):
	var ticks_to_crash =  start_ticks_to_crash - Globals.time_controller.current_ticks_ms
	if rapid:
		rapid_scalar += delta * 5000000000
		ticks_to_crash -= rapid_scalar
	var days = floor(ticks_to_crash / (24 * 60 * 60 * 1000))
	
	ticks_to_crash = ticks_to_crash - (days * 24 * 60 * 60 * 1000)
	
	var hours = floor(ticks_to_crash / (60 * 60 * 1000))
	ticks_to_crash = ticks_to_crash - (hours * 60 * 60 * 1000)
	
	var minutes = floor(ticks_to_crash / (60 * 1000))
	ticks_to_crash -= minutes * 60 * 1000
	
	var seconds = floor(ticks_to_crash / 1000)
	
	if days < 0 :  days = 0
	if hours < 0 :  hours = 0
	if minutes < 0 :  minutes = 0
	if seconds < 0 :  seconds = 0
	
	crash_timer_label.text = "%04d:%02d:%02d:%02d" % [days, hours, minutes, seconds]


func _on_throttle_interactee_game_end_lockout():
	rapid = true
