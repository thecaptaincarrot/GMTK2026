extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("testing event bus")
	var event_bus := MessageBus.create()
	event_bus.handle(Turn.new(Turn.Direction.LEFT))