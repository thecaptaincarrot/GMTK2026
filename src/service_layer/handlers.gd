extends RefCounted

class_name Handlers

# Command handlers

static func turn(cmd: Turn) -> Variant:
	match cmd.direction:
		Turn.Direction.LEFT:
			# TODO add custom behavior
			print("command received, turn LEFT")
		Turn.Direction.RIGHT:
			# TODO add custom behavior
			print("command received, turn RIGHT")
		_:
			return "unsupported turn direction: %s" % cmd.direction
 
	return [Turned.new(cmd.direction)]

# Event Handlers
static func log_turn(event: Turned) -> Variant:
	print("player turned: %s" % Turn.Direction.keys()[event.direction])
	return null
 
 
static func play_turn_sound(event: Turned) -> Variant:
	print("I'M PLAYING THE SOUND OF TURNING %s" % Turn.Direction.keys()[event.direction])
	return null

# Declare commands here
# a command MUST have only one handler
# a command is something you want to happen
static func command_handlers() -> Dictionary:
	return {
		Turn: Callable(Handlers, "turn"),
	}
 
# Declare events here
# An event can have multiple handlers
# an event is a consequence of something that happened
static func event_handlers() -> Dictionary:
	return {
		Turned: [
			Callable(Handlers, "log_turn"),
			Callable(Handlers, "play_turn_sound"),
		],
	}