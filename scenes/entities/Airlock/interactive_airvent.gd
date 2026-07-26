extends Interactee

@onready var jumpsuit_mesh = $jumpsuit_001
@onready var interactable_shape = $Interactable/CollisionShape3D

@export var indicator_panels : Array[Node3D]

var jumpsuit_removed = false

func handle_interaction():
	if jumpsuit_removed == false:
		jumpsuit_removed = true
		#Make this a tween showing it get removed?
		#Particles?
		interacted_with.emit()
		#TODO: Play air rushing sound effect
		AudioPlayer.create_audio("VentUnblock")
		#hide mesh
		jumpsuit_mesh.hide()
		interactable_shape.disabled = true
		
		#turn off the indicator light
		for panel in indicator_panels:
			panel.turn_off_vent_failure()
