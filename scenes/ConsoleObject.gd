extends Note

func _ready():
	super()


func disable_collision():
	collision_area.disabled = true

func enable_collision():
	if !Globals.reactor_started:
		collision_area.disabled = false
