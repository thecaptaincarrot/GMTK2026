extends Node3D

@export var rotation_speed = PI/128

func _physics_process(delta):
	rotation.y += rotation_speed * delta
