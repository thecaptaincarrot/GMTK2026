extends Node3D
class_name PlayerController


	#at some point this will need to be hooked into event bus
func _on_right_arrow_pressed() -> void:
	rotate(Vector3(0, 1, 0), deg_to_rad(-90))


func _on_left_arrow_pressed() -> void:
	rotate(Vector3(0, 1, 0), deg_to_rad(90))
