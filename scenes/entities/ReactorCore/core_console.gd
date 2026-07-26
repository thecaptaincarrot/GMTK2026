extends Interactee

@onready var button_mesh = $coreconsole_001
@export var engine_core : EngineCore

var animating = false
var button_blend_shape_value = 0.0

func handle_interaction():
	animate_button()
	if engine_core._is_active():
		return
	
	if engine_core.in_startup_period():
		engine_core.activate()
	#Get timer
	#if timer is within 1 minute of start time, go nuts
	push_warning("No interaction set for interactee ", name)


func animate_button():
	AudioPlayer.create_audio("Button")
	animating = true
	var tween = create_tween()
	tween.tween_property(self, "button_blend_shape_value",1.0,0.06)
	tween.tween_property(self, "button_blend_shape_value",0.0,0.06)
	await tween.finished
	animating = false


func _physics_process(_delta):
	if animating:
		button_mesh.set_blend_shape_value(0,button_blend_shape_value)
