extends Node3D


@onready var knobs = [$knobwidget/Knob1,$knobwidget/Knob2,$knobwidget/Knob3,$knobwidget/Knob4]

@onready  var knob_value_label = $KnobValueLabel


func _ready():
	knob_value_label.hide()
	Globals.reactor_started_signal.connect(knob_value_label.show)
	
	for knob in knobs:
		knob.knob_mesh.set_surface_override_material(1,Globals.console_off_material)
		Globals.reactor_started_signal.connect(knob.knob_mesh.set_surface_override_material.bind(1,Globals.active_material))
	
	$knobwidget.set_surface_override_material(1, Globals.console_off_material)
	Globals.reactor_started_signal.connect($knobwidget.set_surface_override_material.bind(1,Globals.console_on_material))
	
	for knob in knobs:
		knob.knob_updated.connect(update_knob_label)


func enable_collision():
	for knob in knobs:
		knob.enable_collision()


func get_knob_value():
	var total_value = 0
	for knob in knobs:
		total_value += knob.get_knob_value()
	return total_value


func update_knob_label():

	knob_value_label.text = str(get_knob_value())


func check_solution():
	if get_knob_value() == Globals.time_controller.get_minutes_since_midnight():
		return true
	else:
		return false
