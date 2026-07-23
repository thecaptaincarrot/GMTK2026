extends Node

var message_bus:MessageBus = MessageBus.create()



var _active_interactable:Node

signal interactable_updated

func get_interacable():
	return _active_interactable

func set_interactable(node):
	_active_interactable = node
	emit_signal("interactable_updated")

func clear_interactable(node):
	emit_signal("interactable_updated")
	_active_interactable = null
