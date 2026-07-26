extends Node3D
class_name position_indicator

@onready var black_hole_indicator_rotator = $crashwidget_001/BlackHoleIndicator

@onready var indicator_mark_container = $crashwidget_001/IndicatorMarks
@onready var ship_mesh_1 = $crashwidget_001/ShipMesh1
@onready var ship_mesh_2 = $crashwidget_001/ShipMesh2
@onready var dial_backgrund = $crashwidget_001/Background

@onready var ship_mesh_mat = load("res://scenes/entities/Cockpit/ShipIndicatorMaterial.tres")

var black_hole_rotation = 0.0


func _ready():
	Globals.reactor_started_signal.connect(ship_mesh_1.set_surface_override_material.bind(0,ship_mesh_mat))
	Globals.reactor_started_signal.connect(ship_mesh_2.set_surface_override_material.bind(0,ship_mesh_mat))
	
	Globals.reactor_started_signal.connect(dial_backgrund.set_surface_override_material.bind(0,Globals.active_material))
	dial_backgrund.set_surface_override_material(0,Globals.inactive_material)
	
	ship_mesh_1.set_surface_override_material(0,Globals.inactive_material)
	ship_mesh_2.set_surface_override_material(0,Globals.inactive_material)

func rotation_updated(new_rotation):
	black_hole_indicator_rotator.rotation.y = -new_rotation
	black_hole_rotation = -new_rotation

func check_solution():
	var limited_rotation = black_hole_rotation
	while limited_rotation < -2 * PI or limited_rotation > 2 * PI:
		if limited_rotation < -2 * PI:
			limited_rotation += 2 * PI
		else:
			limited_rotation -= 2 * PI
	if abs(limited_rotation - 4*PI/3) < PI/8 or abs(limited_rotation + 4*PI/3) < PI/8:
		return true
	return false
