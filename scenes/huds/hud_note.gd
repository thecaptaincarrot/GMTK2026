extends HudBase

class_name HudNote

@onready var note_display = $NoteControl/NoteDisplay

@onready var previous_button = $NoteControl/NoteDisplay/NotePrevious
@onready var next_button = $NoteControl/NoteDisplay/NoteNext

var _note_pages: Array[Texture2D]
var _current_page: int = 0

func _ready() -> void:
	_note_pages = Globals.get_active_note()
	_current_page = 0
	render_current_page()


func _on_note_next_pressed() -> void:
	_current_page = min(_note_pages.size() - 1, _current_page + 1)
	render_current_page()


func _on_note_exit_pressed() -> void:
	Input.set_custom_mouse_cursor(Globals.cursor_default_arrow)
	AudioPlayer.create_audio("Paper")
	Globals.hud_controller.revert_hud_state()

func _on_note_previous_pressed() -> void:
	_current_page = max(0, _current_page - 1)
	render_current_page()

func render_current_page():
	note_display.texture = _note_pages[_current_page]
	AudioPlayer.create_audio("Paper")
	if _current_page == 0:
		previous_button.disabled = true
		previous_button.mouse_filter = Control.MOUSE_FILTER_IGNORE
	else:
		previous_button.disabled = false
		previous_button.mouse_filter = Control.MOUSE_FILTER_STOP
	
	if _current_page == _note_pages.size() - 1:
		next_button.disabled = true
		next_button.mouse_filter = Control.MOUSE_FILTER_IGNORE
	else:
		next_button.disabled = false
		next_button.mouse_filter = Control.MOUSE_FILTER_STOP


func _on_note_display_mouse_entered():
	Input.set_custom_mouse_cursor(Globals.cursor_default_arrow)


func _on_note_next_mouse_entered():
	if next_button.disabled == false:
		Input.set_custom_mouse_cursor(Globals.cursor_right_arrow)


func _on_note_previous_mouse_entered():
	if previous_button.disabled == false:
		Input.set_custom_mouse_cursor(Globals.cursor_left_arrow)


func _on_note_exit_mouse_entered():
	Input.set_custom_mouse_cursor(Globals.cursor_backwards_arrow)
