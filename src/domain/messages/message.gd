extends RefCounted

class_name Message

func _to_string() -> String:
	# is this how you really get the child name???
	return self.get_script().resource_path.get_file().get_basename()
