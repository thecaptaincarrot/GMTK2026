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


func _on_toggle_camera_transitions_pressed() -> void:
	Globals.should_tween = not Globals.should_tween
	print("Camera Transitions %s" % Globals.should_tween)


func _on_activate_reactor_pressed() -> void:
	var reactor_button = get_tree().current_scene.find_child("EngineCore", true, false)
	if not reactor_button.active:
		reactor_button.activate()
