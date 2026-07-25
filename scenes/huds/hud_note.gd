extends HudBase

class_name HudNote


var _note: NoteData
var _current_page: int = 0

func _ready() -> void:
	_note = Globals.get_active_note()
	_current_page = 0
	render_current_page()


func _on_note_next_pressed() -> void:
	_current_page = min(_note.pages.size() - 1, _current_page + 1)
	render_current_page()


func _on_note_exit_pressed() -> void:
	# Todo sometimes the previous hud might be a zoomed in HUD instead of an explore HUD?
	# Need to account for that
	Globals.hud_controller.set_hud(HudController.HudState.EXPLORE)

func _on_note_previous_pressed() -> void:
	_current_page = max(0, _current_page - 1)
	render_current_page()

func render_current_page():
	print("page %s" % _note.pages[_current_page])