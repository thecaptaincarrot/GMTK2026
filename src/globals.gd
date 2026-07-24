extends Node

var message_bus: MessageBus = MessageBus.create()


# var _active_interactable: Node
var _player: PlayerController

func set_player(p: PlayerController) -> void:
	_player = p

func get_player() -> PlayerController:
	return _player

# signal interactable_updated

# func get_interactable():
# 	return _active_interactable

# func set_interactable(node):
# 	_active_interactable = node
# 	emit_signal("interactable_updated")

# func clear_interactable(node):
# 	emit_signal("interactable_updated")
# 	_active_interactable = null
