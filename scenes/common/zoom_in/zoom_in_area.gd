extends Camera3D
class_name ZoomIn

@onready var interactable = $Interactable
@onready var collision_area = $Interactable/CollisionShape3D

@export var valid_clickables: Array[Node3D]
@export var valid_neighbors: Array[ZoomIn]

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


func handle_interaction() -> void:
	assert(Globals.get_last_position() != null, "zoom in menu needs a position to return to")
	assert(Globals.get_last_position().valid_clickables.has(self), "last position must be one that gives access to current zoom menu")

	var player: PlayerController = Globals.get_player()
	Globals.hud_controller.set_hud(HudController.HudState.ZOOMED_IN)
	
	game_room.disable_all_position_colliders()
	_stored_last_yaw = player.global_rotation.y
	
	if(Globals.should_tween):
		player.change_position(self.get_global_position(), self.global_rotation, self.fov)
		await player.movement_finished
	else:
		player.set_global_rotation(self.global_rotation)
		player.set_global_position(self.get_global_position())
		player.camera.fov  = self.fov
	disable_collision()
	enable_neighbors()
