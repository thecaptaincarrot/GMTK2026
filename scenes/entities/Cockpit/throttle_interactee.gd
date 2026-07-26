extends Interactee

@onready var throttle_mesh = $throttle

@export var switches : Node3D
@export var knobs : Node3D
@export var indicator : position_indicator

@export var ending_sound : AudioStreamPlayer
@export var cover_rect : ColorRect

var throttle_shape_key_value = 0.0
signal game_end_lockout
signal game_won

func _ready():
	super()
	
	$throttle.set_surface_override_material(1,Globals.inactive_material)
	Globals.reactor_started_signal.connect($throttle.set_surface_override_material.bind(1,Globals.active_material))


func handle_interaction():
	print("Checking throttle. Switches: ", switches.check_solution(), " knobs:", knobs.check_solution(), " rotation: ", indicator.check_solution())
	if (switches.check_solution() and knobs.check_solution() and indicator.check_solution()):
		game_end_lockout.emit()
		cover_rect.mouse_filter = Control.MOUSE_FILTER_STOP 
		var new_tween = create_tween()
		new_tween.tween_callback(ending_sound.play)
		new_tween.tween_property(self,"throttle_shape_key_value",1,4)
		new_tween.tween_interval(5.0)
		new_tween.tween_property(cover_rect,"color",Color(0.0,0.0,0.0,1.0),4)
		#Fade to black
		await new_tween.finished
		game_won.emit()
	else:
		var new_tween = create_tween()
		new_tween.tween_property(self,"throttle_shape_key_value",0.1,0.1)
		new_tween.tween_property(self,"throttle_shape_key_value",0.0,0.1)
		new_tween.tween_property(self,"throttle_shape_key_value",0.1,0.1)
		new_tween.tween_property(self,"throttle_shape_key_value",0.0,0.1)
		new_tween.tween_property(self,"throttle_shape_key_value",0.1,0.1)
		new_tween.tween_property(self,"throttle_shape_key_value",0.0,0.1)


func _physics_process(delta):
	throttle_mesh.set_blend_shape_value(0,throttle_shape_key_value)
