extends Node3D

@onready var switches : Array[Node3D] = [$switches,$switches2,$switches3,$switches4]

func _ready():
	pass


func enable_collision():
	for switch in switches:
		switch.enable_collision()


func check_solution():
	for switch in switches:
		if !switch.is_solution():
			return false
	return true
