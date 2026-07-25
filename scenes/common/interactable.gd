extends Area3D
class_name Interactable

@export var interactee: Node

func _ready():
	input_event.connect(_on_input_event)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

# add interactable to a marker3d to automatically change cursor type
func _on_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(Globals.cursor_up_arrow)

func _on_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(Globals.cursor_default_arrow)

# each interactable pass the command to the interactee node and let the parent handle the behavior
# different parents can have different behaviors
func _on_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event.is_action_pressed("mouse_interact"):
		interactee.handle_interaction()
