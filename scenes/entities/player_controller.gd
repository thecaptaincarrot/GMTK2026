extends Node3D
class_name PlayerController

@export var camera:Camera3D

@export var movement_time := .3

var lock_transform := false

func rotate_screen(deg: float):
	if lock_transform:
		return
	lock_transform = true
	var tween = create_tween()
	tween.tween_property(self, "rotation_degrees", Vector3(rotation_degrees.x, rotation_degrees.y + deg, rotation_degrees.z), movement_time)
	await tween.finished
	lock_transform = false

func change_position(pos: Vector3, rot:Vector3, fov : float):
	if lock_transform:
		return
	lock_transform = true
	var target := Quaternion(rot.normalized(), PI / 2)
	var tween = create_tween()
	tween.set_parallel()
	tween.tween_property(self, "global_rotation", target, movement_time)
	tween.tween_property(self, "global_position", pos, movement_time)
	tween.tween_property(camera, "fov", fov, movement_time)
	await tween.finished
	lock_transform = false
