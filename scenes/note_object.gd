extends MeshInstance3D


@export var note_data: NoteData
@export var collision_area: CollisionShape3D


func disable_collision():
	collision_area.disabled = true

func enable_collision():
	collision_area.disabled = false


func handle_interaction() -> void:
	Globals.set_active_note(note_data)
	Globals.hud_controller.set_hud(HudController.HudState.READING_NOTE)
