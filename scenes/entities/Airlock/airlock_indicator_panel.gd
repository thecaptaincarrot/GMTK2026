extends Node3D
@export var electrical_fault = false

@onready var switchboard_mesh = $switchboard4_001

@onready var light_on_material =  load("res://assets/Materials/RedEmission/RedEmissionMaterial.tres")
@onready var light_off_material =  load("res://assets/Materials/RedEmission/RedOffMaterial.tres")

@onready var vent_fail_omni_light = $switchboard4_001/VentFailOmniLight

@onready var electrical_fault_omni_light = $switchboard4_001/VentFailOmniLight

func _ready():
	if electrical_fault:
		electrical_fault_omni_light.show()
		switchboard_mesh.set_surface_override_material(3,light_on_material)
	else:
		electrical_fault_omni_light.hide()
		switchboard_mesh.set_surface_override_material(3,light_off_material)


func blink_vent_failure():
	var new_tween = create_tween()
	new_tween.tween_callback(switchboard_mesh.set_surface_override_material.bind(1,light_off_material))
	new_tween.tween_callback(vent_fail_omni_light.hide)
	new_tween.tween_interval(0.2)
	new_tween.tween_callback(AudioPlayer.create_audio.bind("LightBeep"))
	new_tween.tween_callback(switchboard_mesh.set_surface_override_material.bind(1,light_on_material))
	new_tween.tween_callback(vent_fail_omni_light.show)
	new_tween.tween_interval(0.2)
	new_tween.tween_callback(switchboard_mesh.set_surface_override_material.bind(1,light_off_material))
	new_tween.tween_callback(vent_fail_omni_light.hide)
	new_tween.tween_interval(0.2)
	new_tween.tween_callback(AudioPlayer.create_audio.bind("LightBeep"))
	new_tween.tween_callback(switchboard_mesh.set_surface_override_material.bind(1,light_on_material))
	new_tween.tween_callback(vent_fail_omni_light.show)
	new_tween.tween_interval(0.2)
	new_tween.tween_callback(switchboard_mesh.set_surface_override_material.bind(1,light_off_material))
	new_tween.tween_callback(vent_fail_omni_light.hide)
	new_tween.tween_interval(0.2)
	new_tween.tween_callback(AudioPlayer.create_audio.bind("LightBeep"))
	new_tween.tween_callback(switchboard_mesh.set_surface_override_material.bind(1,light_on_material))
	new_tween.tween_callback(vent_fail_omni_light.show)
	new_tween.play()


func turn_off_vent_failure():
	switchboard_mesh.set_surface_override_material(1,light_off_material)
	vent_fail_omni_light.hide()
