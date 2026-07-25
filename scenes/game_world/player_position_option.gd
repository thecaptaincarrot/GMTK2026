extends Camera3D
class_name PlayerPositionOption

@export var collision_area: CollisionShape3D

@export var valid_neighbors:Array[Node]

@export var game_room:GameRoom

@onready var interactable = $Interactable

func _ready():
	interactable.camera_area = true

func disable_collision():
	collision_area.disabled = true

func enable_collision():
	collision_area.disabled = false

func enable_neighbors():
	for n in valid_neighbors:
		n.enable_collision()

# each interactable object knows how to handle it's own interaction
func handle_interaction() -> void:
	assert(Globals.get_last_position(), "player should arrive from somewhere")
	assert(Globals.get_last_position().valid_neighbors.has(self) or Globals.get_last_position() == self, "not a valid neighbor")

	var player = Globals.get_player()
	if player:
		#this is here so that we are only clicking on valid neighbors for movement
		Globals.set_last_position(self)
		game_room.disable_all_position_colliders()
		enable_neighbors()
		
		#sync the pseudo camera to the player camera
		#more can be added but I think this is a good starting point
		
		player.camera.fov = self.fov
		
		if(Globals.should_tween):
			player.change_position(self.get_position(), Vector3(self.global_rotation.x, player.global_rotation.y, self.global_rotation.z))
			
		else:
			player.set_global_rotation(Vector3(self.rotation.x, player.rotation.y, self.rotation.z))
			player.set_global_position(self.get_global_position())
