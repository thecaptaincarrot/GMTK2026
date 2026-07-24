extends Camera3D
class_name PlayerPositionOption

@export var collision_area: CollisionShape3D

@export var valid_neighbors:Array[Node]

@export var game_room:GameRoom


func disable_collision():
	collision_area.disabled = true

func enable_collision():
	collision_area.disabled = false

func enable_neighbors():
	for n in valid_neighbors:
		n.enable_collision()

# each interactable object knows how to handle it's own interaction
func handle_interaction() -> void:
	if(Globals.last_position_node != null):
		if(!Globals.last_position_node.valid_neighbors.has(self)):
			return
	var player = Globals.get_player()
	if player:
		
		#this is here so that we are only clicking on valid neighbors for movement
		Globals.last_position_node = self
		game_room.disable_all_position_colliders()
		enable_neighbors()
		
		if(Globals.should_tween):
			player.change_position(self.get_position())
		else:
			player.set_global_position(self.get_position())
