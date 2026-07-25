extends Node3D
class_name Door

@onready var right_door = $doorpanelA
@onready var left_door = $doorpanelB

@onready var mouse_eater = $MouseEaterArea/MouseEaterShape  #Mouse eater stops you clicking through the door

var _is_open = false

#TODO: Doors should close when you travel to a new location

func open_door():
	var new_tween = create_tween()
	new_tween.set_parallel()
	new_tween.tween_property(right_door,"position", Vector3(0.8,0.0,0.0), 0.2)
	new_tween.tween_property(left_door,"position", Vector3(-0.8,0.0,0.0), 0.2)
	
	#TODO: Play sound effect
	
	#Disable mouse eater area
	mouse_eater.disabled = true
	
	_is_open = true


func  close_door():
	var new_tween = create_tween()
	new_tween.set_parallel()
	new_tween.tween_property(right_door,"position", Vector3(0.0,0.0,0.0), 0.2)
	new_tween.tween_property(left_door,"position", Vector3(0.0,0.0,0.0), 0.2)
	#TODO: Play sound effect
	
	#Enable mouse eater area
	mouse_eater.disabled = false
	
	_is_open = false


func toggle_door():
	if _is_open:
		close_door()
	else:
		open_door()
