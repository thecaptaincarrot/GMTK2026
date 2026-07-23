extends Command

class_name Turn

enum Direction {LEFT, RIGHT, UP, DOWN}

var direction: Direction
 
func _init(_direction: Direction) -> void:
	self.direction = _direction