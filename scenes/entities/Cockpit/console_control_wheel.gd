extends Node3D

@onready var control_mesh = $control_mesh

var idle = true
var target_rotation = 0.0

signal new_black_hole_rotation

func _on_left_control_interacted_with():
	rotate_ship(-PI/6.0)


func _on_right_control_interacted_with():
	rotate_ship(PI/6.0)


func rotate_ship(radian_rotation : float):

	idle = false
	var new_tween = create_tween()
	
	if radian_rotation < 0:
		new_tween.tween_property(control_mesh,"rotation",Vector3(0,PI/4,0),0.2)
	else:
		new_tween.tween_property(control_mesh,"rotation",Vector3(0,-PI/4,0),0.2)
	
	if Globals.reactor_started:
		$RCSjetsstream.play()
		target_rotation += radian_rotation
		new_black_hole_rotation.emit(target_rotation)
	else:
		new_tween.tween_property(control_mesh,"rotation",Vector3(0,0.0,0),0.4)
		idle = true

func rotation_complete():
	$RCSjetsstream.stop()
	var new_tween = create_tween()
	
	new_tween.tween_property(control_mesh,"rotation",Vector3(0,0.0,0),0.2)
	
	idle = true
