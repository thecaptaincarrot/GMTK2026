extends Node

class_name TimeController

var time_multiplier: float = 1
var start_time_ms: int
var current_time_ms: float 
var default_time_pattern: String = "%04d-%02d-%02d %02d:%02d:%02d"
var hour_only_time_pattern: String = "%02d:%02d:%02d"
var started = false



func start(_start_time_ms: int):
	start_time_ms = _start_time_ms
	current_time_ms = start_time_ms
	started = true

func _physics_process(delta: float) -> void:
	if not started:
		return
	var ms_delta: float = delta * 1000
	current_time_ms += ms_delta * time_multiplier

func set_time_multiplier(value) -> void:
	self.time_multiplier = value

func formatted_time_24_h() -> String:
	return self.format_current_time()

func formatted_time_12_h() -> String:
	return self.format_current_time(true)

func format_current_date(is_american = false, pattern: String = default_time_pattern) -> String:
	var unix_time: int  = int(current_time_ms / 1000.0)
	var time_dict = Time.get_datetime_dict_from_unix_time(unix_time)
	var hour: int = time_dict["hour"] % 12 if is_american else time_dict["hour"]

	return pattern % [time_dict["year"], time_dict["month"], time_dict["day"], hour, time_dict["minute"], time_dict["second"]]


func format_current_time(is_american = false, pattern: String = hour_only_time_pattern) -> String:
	var unix_time: int  = int(current_time_ms / 1000.0)
	var time_dict = Time.get_datetime_dict_from_unix_time(unix_time)
	var hour: int = time_dict["hour"] % 12 if is_american else time_dict["hour"]

	return pattern % [hour, time_dict["minute"], time_dict["second"]]
