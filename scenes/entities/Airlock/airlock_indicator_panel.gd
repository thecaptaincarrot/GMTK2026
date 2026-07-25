extends Node3D
@export var electrical_fault = false

@onready var light_on_material =  load("res://scenes/entities/Airlock/LightOnMaterial.tres")
@onready var light_off_material =  load("res://scenes/entities/Airlock/LightOffMaterial.tres")

@onready var vent_fail_light = $PanelMesh/vent_fail_light
@onready var vent_fail_omni_light = $PanelMesh/vent_fail_light/OmniLight3D

@onready var electrical_fault_light = $PanelMesh/elec_fault_light
@onready var electrical_fault_omni_light = $PanelMesh/elec_fault_light/OmniLight3D

func _ready():
	if electrical_fault:
		electrical_fault_omni_light.show()
		electrical_fault_light.set_surface_override_material(0,light_on_material)
	else:
		electrical_fault_omni_light.hide()
		electrical_fault_light.set_surface_override_material(0,light_off_material)


func blink_vent_failure():
	var new_tween = create_tween()
	new_tween.tween_callback(vent_fail_light.set_surface_override_material.bind(0,light_off_material))
	new_tween.tween_callback(vent_fail_omni_light.hide)
	new_tween.tween_interval(0.2)
	new_tween.tween_callback(AudioPlayer.create_audio.bind("LightBeep"))
	new_tween.tween_callback(vent_fail_light.set_surface_override_material.bind(0,light_on_material))
	new_tween.tween_callback(vent_fail_omni_light.show)
	new_tween.tween_interval(0.2)
	new_tween.tween_callback(vent_fail_light.set_surface_override_material.bind(0,light_off_material))
	new_tween.tween_callback(vent_fail_omni_light.hide)
	new_tween.tween_interval(0.2)
	new_tween.tween_callback(AudioPlayer.create_audio.bind("LightBeep"))
	new_tween.tween_callback(vent_fail_light.set_surface_override_material.bind(0,light_on_material))
	new_tween.tween_callback(vent_fail_omni_light.show)
	new_tween.tween_interval(0.2)
	new_tween.tween_callback(vent_fail_light.set_surface_override_material.bind(0,light_off_material))
	new_tween.tween_callback(vent_fail_omni_light.hide)
	new_tween.tween_interval(0.2)
	new_tween.tween_callback(AudioPlayer.create_audio.bind("LightBeep"))
	new_tween.tween_callback(vent_fail_light.set_surface_override_material.bind(0,light_on_material))
	new_tween.tween_callback(vent_fail_omni_light.show)
	new_tween.play()


func turn_off_vent_failure():
	vent_fail_light.set_surface_override_material(0,light_off_material)
	vent_fail_omni_light.hide()
