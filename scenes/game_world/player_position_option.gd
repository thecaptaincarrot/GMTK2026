extends Marker3D
class_name PlayerPositionOption

@export var collision_area: CollisionShape3D


func disable_collision():
	collision_area.disabled = true

func enable_collision():
	collision_area.disabled = false

# each interactable object knows how to handle it's own interaction
func handle_interaction() -> void:
	var player = Globals.get_player()
	if player:
		if(Globals.should_tween):
			player.change_position(self.get_position())
		else:
			player.set_global_position(self.get_position())
