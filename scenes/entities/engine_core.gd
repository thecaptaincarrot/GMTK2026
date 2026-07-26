extends Node3D
class_name EngineCore

enum{cooling, startup}

var state = cooling

@onready var core_object = $engineroom/Solid


@onready var loop_player = $ReactorLoop
@onready var startup_player = $ReactorStartup
@onready var turnover_player = $ReactorTurnoverLoop
@onready var failure_player = $ReactorFailure

var minutes_to_ms = 60000
var seconds_to_ms = 1000

var start_time = 0.0
var first_startup =  2.0 #Minutes  after  game start that the reactor will try to turn on

@export var cooldown_interval = 43 # Minutes the engine needs to cool
@export var startup_interval = 1 #minutes the player has to press the button

var next_startup_interval
var next_startup_end

var last_time = 0.0

var active = false


func _ready():
	start_time = Globals.time_controller.current_time_ms
	last_time = start_time
	next_startup_interval = start_time + first_startup * minutes_to_ms
	next_startup_end = start_time + (first_startup  +  startup_interval) * minutes_to_ms


func _physics_process(_delta):
	if active:
		return
	
	var current_time = Globals.time_controller.current_time_ms
	
	match  state:
		cooling:
			if next_startup_interval > last_time and  next_startup_interval < current_time:
				begin_startup_sequence()
		startup:
			#Pulse reactor lights
			
			if next_startup_end > last_time and  next_startup_end < current_time:
				begin_cooling_sequence()
	
	
	last_time = current_time
	#Check if between the last time and the current time the interval passed


func begin_startup_sequence():
	state = startup
	#start sounds
	
	#pulse reactor lights
	
	next_startup_interval += cooldown_interval * minutes_to_ms

func begin_cooling_sequence():
	state = cooling
	next_startup_end += cooldown_interval * minutes_to_ms



func _is_active():
	return active


func activate():
	active = true
	
	Globals.reactor_started = true
	Globals.reactor_started_signal.emit()


func in_startup_period():
	return state == startup
