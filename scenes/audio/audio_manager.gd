extends Node2D

var REVERB_SETUP_VECTOR = Vector4(0, 0, 0, 0) # room size, damping, spread, dry/wet
var QUEUED_SETUP_VECTOR = Vector4(0, 0, 0, 0)
var TRANSITION_SPEED = 0.3

func getReverb() -> AudioEffectReverb:
	return AudioServer.get_bus_effect(2, 0)

func setReverb() -> void:
	var reverb : AudioEffectReverb = getReverb()
	reverb.room_size = REVERB_SETUP_VECTOR[0]
	reverb.damping = REVERB_SETUP_VECTOR[1]
	reverb.spread = REVERB_SETUP_VECTOR[2]
	reverb.dry = 1 - REVERB_SETUP_VECTOR[3]
	reverb.wet = REVERB_SETUP_VECTOR[3]

func _ready() -> void:
	pass 

func _process(delta: float) -> void:
	if (QUEUED_SETUP_VECTOR != REVERB_SETUP_VECTOR):
		REVERB_SETUP_VECTOR = REVERB_SETUP_VECTOR.lerp(REVERB_SETUP_VECTOR, delta * TRANSITION_SPEED)
	setReverb()
