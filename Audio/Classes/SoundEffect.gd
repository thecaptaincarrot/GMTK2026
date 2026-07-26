extends Resource
class_name SoundEffect

@export_placeholder("Enter Unique ID") var ID : String
@export_range(0,10) var limit : int = 5 #Number of simultaneous sound effects that can play
@export var sound_effect : Array[AudioStream]
@export_range(-40,20) var volume = -10
@export_range(0.0,10.0,0.1) var pitch_scale = 1.0
@export_range(0.0,4.0,0.1) var pitch_randomness = 0.0

var audio_count = 0

func has_open_limit():
	if audio_count >= limit:
		return false
	else:
		return true


func on_audio_finished():
	audio_count -= 1


func increment_audio_count(num:int):
	audio_count += num
