extends Interactee
class_name DoorButton

@export var door : Door

func handle_interaction():
	door.toggle_door()
