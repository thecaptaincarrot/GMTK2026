extends Area3D
class_name PlayerPositionOption

@export var can_go_to_positions: Array[PlayerPositionOption]

func disable_collision():
	$Collider.disabled = true

func enable_collision():
	$Collider.disabled = false


func _on_mouse_entered() -> void:
	Globals.set_interactable(self)


func _on_mouse_exited() -> void:
	Globals.clear_interactable(self)
