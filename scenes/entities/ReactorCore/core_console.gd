extends Interactee


@export var engine_core : EngineCore

func handle_interaction():
	AudioPlayer.create_audio("Button")
	if engine_core._is_active():
		return
	
	if engine_core.is_startup():
		engine_core.activate()
	#Get timer
	#if timer is within 1 minute of start time, go nuts
	push_warning("No interaction set for interactee ", name)
