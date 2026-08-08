extends HudBase

class_name HudNote

@onready var text_display_front = $NoteControl/TextDisplayFront
@onready var text_display_back = $NoteControl/TextDisplayBack
@onready var note_display = $NoteControl/NoteDisplay

@onready var previous_button = $NoteControl/NoteDisplay/NotePrevious
@onready var next_button = $NoteControl/NoteDisplay/NoteNext

var _note_pages: Array[Texture2D]
var _text_pages_front: Array[Texture2D]
var _text_pages_back: Array[Texture2D]
var _current_page: int = 0

func _ready() -> void:
	_note_pages = Globals.get_active_note()
	_text_pages_front = Globals.get_active_text_pages_front()
	_text_pages_back = Globals.get_active_text_pages_back()
	_current_page = 0
	render_current_page()
	if _text_pages_front != []:
		#it's a  binder
		next_button.size = Vector2(444.5, 700)
		next_button.position = Vector2(402.5,0)
		
		previous_button.size = Vector2(444.5, 700)
		previous_button.position = Vector2(-65.0,0)
	# Connect signals
	SignalBus.note_put_away.connect(_on_note_exit_pressed)


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
	if _text_pages_front != [] and _current_page - 1 >= 0  and _current_page - 1 <  _text_pages_front.size():
		text_display_front.texture = _text_pages_front[_current_page - 1]
	else:
		text_display_front.texture = null
	if _text_pages_back != [] and _current_page - 2 >= 0 and _current_page - 2 <  _text_pages_back.size():
		text_display_back.texture = _text_pages_back[_current_page - 2]
	else:
		text_display_back.texture = null
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
