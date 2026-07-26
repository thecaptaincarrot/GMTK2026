extends Interactee

@export var binder_button : TextureButton

func _ready():
	super()
	$Label3D.hide()
	Globals.reactor_started_signal.connect($Label3D.show)


func handle_interaction():
	if Globals.reactor_started:
		interacted_with.emit()
		Globals.binder_collected = true
		Globals.open_binder()
		hide()

func  enable_collision():
	if get_interactable() and !Globals.binder_collected:
		get_interactable().enable_collision()


func  disable_collision():
	if get_interactable():
		get_interactable().disable_collision()
