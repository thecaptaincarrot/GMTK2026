extends Node3D

@onready var knob_up : Interactee = $KnobUpInteractee
@onready var knob_down : Interactee = $KnobDownInteractee

@onready var knob_mesh = $knob

@export var increment = 1000
var knob_position = 0

signal knob_updated

func _ready():
	update_knob_mesh()
	
	knob_up.interacted_with.connect(knob_turned_up)
	knob_down.interacted_with.connect(knob_turned_down)


func enable_collision():
	knob_up.enable_collision()
	knob_down.enable_collision()


func knob_turned_up():
	AudioPlayer.create_audio("Knob")
	knob_position += 1
	if knob_position >= 9:
		knob_position = 9
	update_knob_mesh()
	knob_updated.emit()


func knob_turned_down():
	AudioPlayer.create_audio("Knob")
	knob_position -= 1
	if knob_position <= 0:
		knob_position = 0
	
	update_knob_mesh()
	knob_updated.emit()


func update_knob_mesh():
	knob_mesh.rotation_degrees.y = 120 - knob_position * 30


func get_knob_value():
	return increment * knob_position
