extends RefCounted

class_name MessageBus

var event_handlers: Dictionary
var command_handlers: Dictionary

var queue: Array[Message] = []

var _player:PlayerController = null

var _active_room:GameRoom = null

func _init(_event_handlers: Dictionary, _command_handlers: Dictionary) -> void:
	event_handlers = _event_handlers
	command_handlers = _command_handlers

func handle(message: Message) -> void:
	queue = [message]
	while not queue.is_empty():
		var current_message: Message = queue.pop_front()
		if current_message is Event:
			self.handle_event(current_message)
		elif current_message is Command:
			self.handle_command(current_message)
		else:
			push_error("Can't handle this message %s" % current_message)

func handle_event(event: Event):
	print("handling event %s " % event)
	for handler in event_handlers.get(event.get_script(), []):
		var result = handler.call(event)
		if result is Array:
			queue.append_array(result)


func handle_command(command: Command):
	print("handling command %s " % command)
	var handler: Callable = command_handlers[command.get_script()]
	var result = handler.call(command)
	if result is Array:
			queue.append_array(result)

static func create() -> MessageBus:
	return MessageBus.new(Handlers.event_handlers(), Handlers.command_handlers())
