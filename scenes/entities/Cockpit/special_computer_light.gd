extends Node3D

func _ready():
	Globals.reactor_started_signal.connect(hide)
