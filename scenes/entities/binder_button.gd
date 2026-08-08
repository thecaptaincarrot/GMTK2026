extends TextureButton


@export var note_pages : Array[Texture2D]

func _on_pressed():
	SignalBus.open_binder.emit()


func _on_research_binder_interacted_with():
	show()
