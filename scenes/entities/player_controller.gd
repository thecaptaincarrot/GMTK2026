extends Node3D
class_name PlayerController

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

func change_position(pos: Vector3):
	if lock_transform:
		return
	lock_transform = true
	var tween = create_tween()
	tween.tween_property(self, "global_position", pos, movement_time)
	await tween.finished
	lock_transform = false
