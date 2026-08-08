extends Note
@export var binder_page = 0


func handle_interaction() -> void:
	if requires_reactor:
		if Globals.reactor_started:
			if Globals.binder_collected:
				Globals.notes_collected.append(binder_page)
				SignalBus.open_binder.emit()
				hide()
			else:
				SignalBus.note_inspect.emit(note_pages)

	else:
		SignalBus.note_inspect.emit(note_pages)
		hide()


func enable_collision():
	if !Globals.notes_collected.has(binder_page) and Globals.reactor_started:
		collision_area.disabled = false
