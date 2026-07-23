extends Area3D
class_name PlayerPositionOption

signal mouse_in_area
signal mouse_left_area

func disable_collision():
	$Collider.disabled = true

func enable_collision():
	$Collider.disabled = false

func _on_mouse_entered() -> void:
	emit_signal("mouse_in_area", int(name))


func _on_mouse_exited() -> void:
	emit_signal("mouse_left_area", int(name))
