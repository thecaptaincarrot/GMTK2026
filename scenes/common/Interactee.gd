extends Node3D
class_name Interactee


func handle_interaction():
	push_warning("No interaction set for interactee ", name)


func get_interactable() -> Interactable:
	for child in get_children():
		if child is Interactable:
			return child
	return  null


func  enable_collision():
	if get_interactable():
		get_interactable().enable_collision()


func  disable_collision():
	if get_interactable():
		get_interactable().disable_collision()
