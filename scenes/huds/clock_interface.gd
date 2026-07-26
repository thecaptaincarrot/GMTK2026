extends CanvasLayer

@onready var clock_label = $ClockLabel

func _physics_process(_delta):
	clock_label.text = Globals.time_controller.formatted_time_24_h()
