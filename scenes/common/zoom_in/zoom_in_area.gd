extends Camera3D
class_name ZoomIn

@onready var interactable = $Interactable
@onready var collision_area = $Interactable/CollisionShape3D

@export var valid_clickables: Array[Node3D]
@export var valid_neighbors: Array[ZoomIn]

@export var parent_zoomin : ZoomIn

var game_room:GameRoom

var _stored_last_yaw = 0.0

func _ready():
	interactable.camera_area = true

func disable_collision():
	collision_area.disabled = true

func enable_collision():
	collision_area.disabled = false


func enable_neighbors():
	for n in valid_neighbors:
		n.enable_collision()
	for n  in valid_clickables:
		n.enable_collision()
	Globals.enable_HUD_buttons.emit()


func move_player_to_position(from_sub_zoom = false):
	var player: PlayerController = Globals.get_player()
	SignalBus.zoom_in.emit()
	
	disable_collision()
	game_room.disable_all_clickables()
	_stored_last_yaw = player.global_rotation.y
	
	if(Globals.should_tween):
		player.change_position(self.get_global_position(), self.global_rotation, self.fov)
		await player.movement_finished
	else:
		player.set_global_rotation(self.global_rotation)
		player.set_global_position(self.get_global_position())
		player.camera.fov  = self.fov
	
	if Globals.is_zoomed_in() and !Globals._sub_zoom_in and !from_sub_zoom:
		Globals._sub_zoom_in = true
	else:
		Globals._sub_zoom_in = false
		Globals._last_zoom_in_node = self
	
	Globals.set_is_zoomed_in(true)
	enable_neighbors()


func handle_interaction() -> void:
	#Where we're going we don't need error checking
	#assert(Globals.get_last_position() != null, "zoom in menu needs a position to return to")
	#assert(Globals.get_last_position().valid_clickables.has(self), "last position must be one that gives access to current zoom menu")
	move_player_to_position()
	
