extends MeshInstance3D
class_name Note


@onready var collision_shape = $Interactable/CollisionShape3D

@export var requires_reactor = false

@export var note_pages : Array[Texture2D]
@export var collision_area: CollisionShape3D

func _ready():
	collision_shape.shape.size.x = mesh.size.x * 1.15
	collision_shape.shape.size.z = mesh.size.y * 1.15


func disable_collision():
	collision_area.disabled = true

func enable_collision():
	if requires_reactor:
		if Globals.reactor_started:
			collision_area.disabled = false
	else:
		collision_area.disabled = false


func handle_interaction() -> void:
	if requires_reactor:
		if Globals.reactor_started:
			Globals.set_active_note(note_pages)
			Globals.hud_controller.set_hud(HudController.HudState.READING_NOTE)
	else:
		Globals.set_active_note(note_pages)
		Globals.hud_controller.set_hud(HudController.HudState.READING_NOTE)
