extends Interactee
class_name DoorButton

@export var door : Door

func handle_interaction():
	AudioPlayer.create_audio("Button")
	
	door.toggle_door()
