extends Node3D
@export var lit_parts : Array[MeshInstance3D]

func _ready():
	for part in lit_parts:
		part.set_surface_override_material(1,Globals.half_active_material)
		Globals.reactor_started_signal.connect(part.set_surface_override_material.bind(1,Globals.active_material))
