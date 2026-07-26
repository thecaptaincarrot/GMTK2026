extends Node3D
class_name EngineCore

enum{cooling, startup, activated}

var state = cooling

@onready var core_object = $engineroom/demoncore_002
@onready var core_light = $engineroom/demoncore_002/OmniLight3D

@onready var reactor_material :  StandardMaterial3D = load("res://scenes/entities/ReactorCore/ReactorEmissionMaterial.tres")


@onready var loop_player = $ReactorLoop
@onready var startup_player = $ReactorStartup
@onready var turnover_player = $ReactorTurnoverLoop
@onready var failure_player = $ReactorFailure

var minutes_to_ms = 60000
var seconds_to_ms = 1000

var start_time = 0.0
var first_startup =  1.0 #Minutes  after  game start that the reactor will try to turn on

@export var cooldown_interval = 25 # Minutes the engine needs to cool
@export var startup_interval = 5.0 #minutes the player has to press the button

var next_startup_interval
var next_startup_end

var last_time = 0.0

var active = false

var t = 0

func _ready():
	next_startup_interval = first_startup * minutes_to_ms
	next_startup_end = (first_startup  +  startup_interval) * minutes_to_ms


func _physics_process(delta):
	if active:
		return
	var current_time = Globals.time_controller.current_ticks_ms
	match  state:
		cooling:
			if reactor_material.emission_energy_multiplier > 0.5:
				reactor_material.emission_energy_multiplier -= delta * 0.2
			if  reactor_material.emission.v > 0.5:
				reactor_material.emission.v -= delta * 0.2
			if core_light.light_energy > 0.0:
				core_light.light_energy -= delta  * 0.2
			if next_startup_interval < current_time:
				begin_startup_sequence()
		startup:
			#Pulse reactor lights
			t += delta
			reactor_material.emission_energy_multiplier  = 1.0 + sin(t) * 0.5
			reactor_material.emission.v = 0.75 + sin(t) * 0.25
			
			core_light.light_energy = sin(t)  * 0.4  +  0.5
			
			if next_startup_end < current_time:
				begin_cooling_sequence()
		
	
	
	last_time = current_time
	#Check if between the last time and the current time the interval passed


func begin_startup_sequence():
	t = 0
	state = startup
	#start sounds
	turnover_player.play()
	
	next_startup_interval += cooldown_interval * minutes_to_ms


func begin_cooling_sequence():
	state = cooling
	next_startup_end += cooldown_interval * minutes_to_ms
	
	turnover_player.stop()
	failure_player.play()


func _is_active():
	return active


func activate():
	state = activated
	turnover_player.stop()
	active = true
	
	startup_audio_tween()
	
	Globals.reactor_started = true
	Globals.reactor_started_signal.emit()


func in_startup_period():
	return state == startup


func startup_audio_tween():
	var new_tween = create_tween()
	
	new_tween.tween_callback(startup_player.play)
	new_tween.tween_interval(6)
	new_tween.tween_callback(loop_player.play)
