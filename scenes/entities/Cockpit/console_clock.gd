extends Node3D
@onready var off_mat : StandardMaterial3D = load("res://scenes/entities/Cockpit/ConsoleOffMaterial.tres")

@onready var grey_clock_mat : StandardMaterial3D = load("res://scenes/entities/Cockpit/Clock/GreyClockMaterial.tres")
@onready var red_clock_mat : StandardMaterial3D  = load("res://scenes/entities/Cockpit/Clock/clock_hour_material.tres")
@onready var pink_clock_mat : StandardMaterial3D  = load("res://scenes/entities/Cockpit/Clock/ClockOnMaterial.tres")

@onready var hour_hand = $clockhand_hour
@onready var minute_hand = $clockhand_minute
@onready var indicator = $analogue_indicators
@onready var digital_widget = $clockwidget
@onready var digital_clock_label = $clockwidget/DigitalClockLabel

func _ready():
	grey_clock_mat.emission_enabled = false
	red_clock_mat.emission_enabled = false
	pink_clock_mat.emission_enabled = false
	
	Globals.reactor_started_signal.connect(grey_clock_mat.set_feature.bind(BaseMaterial3D.FEATURE_EMISSION,true))
	Globals.reactor_started_signal.connect(red_clock_mat.set_feature.bind(BaseMaterial3D.FEATURE_EMISSION,true))
	Globals.reactor_started_signal.connect(pink_clock_mat.set_feature.bind(BaseMaterial3D.FEATURE_EMISSION,true))
	
	digital_widget.set_surface_override_material(1, off_mat)
	
	digital_clock_label.hide()
	Globals.reactor_started_signal.connect(digital_clock_label.show)
	Globals.reactor_started_signal.connect(digital_widget.set_surface_override_material.bind(1, pink_clock_mat))


func _physics_process(delta):
	digital_clock_label.text = Globals.time_controller.format_current_time()
