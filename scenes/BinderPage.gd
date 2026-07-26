extends Note


@export var binder_page = 0


func handle_interaction() -> void:
	if requires_reactor:
		if Globals.reactor_started:
			if Globals.binder_collected:
				Globals.notes_collected.append(binder_page)
				Globals.open_binder()
				queue_free()
			else:
				Globals.set_active_note(note_pages)
				Globals.hud_controller.set_hud(HudController.HudState.READING_NOTE)

	else:
		Globals.set_active_note(note_pages)
		Globals.hud_controller.set_hud(HudController.HudState.READING_NOTE)
