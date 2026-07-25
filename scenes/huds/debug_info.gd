extends CanvasLayer

@onready var time_dilation_label = $VBoxContainer/TimeDilation
@onready var euro_clock_label = $VBoxContainer/EuroTime
@onready var american_clock_label = $VBoxContainer/AmericanTime
@onready var ticks_label = $VBoxContainer/Ticks

func _physics_process(_delta):
	time_dilation_label.text = "Time Dilation: " + str(Globals.time_controller.time_multiplier) +   "x"
	euro_clock_label.text = Globals.time_controller.formatted_time_24_h()
	american_clock_label.text = Globals.time_controller.formatted_time_12_h()
	ticks_label.text = "%.0f" % Globals.time_controller.current_time_ms + " ms"
