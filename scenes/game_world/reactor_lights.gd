extends Node3D


func _ready():
	hide()
	Globals.reactor_started_signal.connect(show)
