extends MeshInstance3D

@export var interactees: Array[Interactee]

func _on_ship_world_disable_cockpit():
	for opt : Interactee in interactees:
		print(opt)
		opt.disable_collision()
