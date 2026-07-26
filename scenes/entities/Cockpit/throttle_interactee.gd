extends Interactee

func _ready():
	super()
	
	$throttle.set_surface_override_material(1,Globals.inactive_material)
	Globals.reactor_started_signal.connect($throttle.set_surface_override_material.bind(1,Globals.active_material))
