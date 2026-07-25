extends Interactee
class_name DoorButton

@onready  var button_mesh =  $doorbutton

@export var door : Door
var button_blend_shape_value = -1.0
var animating = false

func handle_interaction():
	animate_button()
	
	door.toggle_door()


func animate_button():
	AudioPlayer.create_audio("Button")
	animating = true
	var tween = create_tween()
	tween.tween_property(self, "button_blend_shape_value",1.0,0.06)
	tween.tween_property(self, "button_blend_shape_value",-1.0,0.06)
	await tween.finished
	animating = false


func _physics_process(_delta):
	if animating:
		button_mesh.set_blend_shape_value(0,button_blend_shape_value)
