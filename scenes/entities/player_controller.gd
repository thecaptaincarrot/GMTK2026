extends Node3D
class_name PlayerController

@export var camera:Camera3D

@export var movement_time := 1.0
@export var rotation_time := 0.6

var lock_transform := false

signal movement_finished

func rotate_screen(deg: float):
	if lock_transform:
		return
	lock_transform = true
	var tween = create_tween()
	tween.tween_property(self, "rotation_degrees", Vector3(rotation_degrees.x, rotation_degrees.y + deg, rotation_degrees.z), rotation_time)

	var audio_tween = create_tween()
	audio_tween.tween_callback(AudioPlayer.create_audio.bind("Footsteps"))
	audio_tween.tween_interval(0.5)
	audio_tween.tween_callback(AudioPlayer.create_audio.bind("Footsteps"))

	await tween.finished
	lock_transform = false

func change_position(pos: Vector3, rot:Vector3, fov : float):
	if lock_transform:
		return
	lock_transform = true
	var target := Vector3(
		self.global_rotation.x + wrapf(rot.x - self.global_rotation.x, -PI, PI),
		self.global_rotation.y + wrapf(rot.y - self.global_rotation.y, -PI, PI),
		self.global_rotation.z + wrapf(rot.z - self.global_rotation.z, -PI, PI)
	)
	var tween = create_tween()
	tween.set_parallel()
	tween.tween_property(self, "global_rotation", target, movement_time)
	tween.tween_property(self, "global_position", pos, movement_time)
	tween.tween_property(camera, "fov", fov, movement_time)
	
	var audio_tween = create_tween()
	audio_tween.tween_callback(AudioPlayer.create_audio.bind("Footsteps"))
	audio_tween.tween_interval(0.55)
	audio_tween.tween_callback(AudioPlayer.create_audio.bind("Footsteps"))
	audio_tween.tween_interval(0.55)
	audio_tween.tween_callback(AudioPlayer.create_audio.bind("Footsteps"))

	await tween.finished
	movement_finished.emit()
	lock_transform = false


func change_position_instant(pos: Vector3, rot:Vector3, fov : float):
	self.set_global_rotation(rot)
	set_global_position(pos)
	camera.fov = fov
	AudioPlayer.create_audio("Footsteps")
	
