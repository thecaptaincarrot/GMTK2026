extends DoorButton

@export var air_vent : Interactee
@export var indicator_panel : Node3D

func handle_interaction():
	if air_vent.jumpsuit_removed:
		door.toggle_door()
	else:
		var new_tween = create_tween()
		#TODO: Failure sound effect
		new_tween.tween_interval(1.0) #However long the sound effect is
		
		#Flash indicator panel after a  little bit
		new_tween.tween_callback(indicator_panel.blink_vent_failure)
