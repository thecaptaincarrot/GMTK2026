extends Note
@export var binder_page = 0


func handle_interaction() -> void:
	if requires_reactor:
		if Globals.reactor_started:
			if Globals.binder_collected:
				Globals.notes_collected.append(binder_page)
				Globals.open_binder()
				hide()
			else:
				Globals.set_active_note(note_pages)
				Globals.hud_controller.set_hud(HudController.HudState.READING_NOTE)

	else:
		Globals.set_active_note(note_pages)
		Globals.hud_controller.set_hud(HudController.HudState.READING_NOTE)
		hide()


func enable_collision():
	if !Globals.notes_collected.has(binder_page):
		collision_area.disabled = false
