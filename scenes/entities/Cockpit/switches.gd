extends Node3D

@onready var left_switch_interactee : Interactee = $LeftSwitchInteractee
@onready var right_switch_interactee : Interactee = $RightSwitchInteractee

@onready var switch_mesh : MeshInstance3D = $switchboard

@export  var left_important = false
var left_toggled = false

@export var right_important = false
var right_toggled = false


func _ready():
	pass
	switch_mesh.set_surface_override_material(1,Globals.inactive_material)
	switch_mesh.set_surface_override_material(2,Globals.inactive_material)
	Globals.reactor_started_signal.connect(update_switches)


func enable_collision():
	left_switch_interactee.enable_collision()
	right_switch_interactee.enable_collision()


func _on_left_switch_interactee_interacted_with():
	AudioPlayer.create_audio("SwitchFlip")
	left_toggled = !left_toggled
	update_switches()


func _on_right_switch_interactee_interacted_with():
	AudioPlayer.create_audio("SwitchFlip")
	right_toggled = !right_toggled
	update_switches()


func update_switches():
	if Globals.reactor_started:
		if left_toggled:
			switch_mesh.set_surface_override_material(1,Globals.active_material)
			switch_mesh.set_blend_shape_value(0,1.0)
		else:
			switch_mesh.set_surface_override_material(1,Globals.inactive_material)
			switch_mesh.set_blend_shape_value(0,0.0)
		
		if right_toggled:
			switch_mesh.set_surface_override_material(2,Globals.active_material)
			switch_mesh.set_blend_shape_value(1,1.0)
		else:
			switch_mesh.set_surface_override_material(2,Globals.inactive_material)
			switch_mesh.set_blend_shape_value(1,0.0)


func is_solution():
	return (right_important == right_toggled) && (left_important == left_toggled)
