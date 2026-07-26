extends Node


var main_scene

func _ready():
	start_animation()

func  start_animation():
	$AnimationPlayer.play("ending_cutscene")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "ending_cutscene":
		#Transition to credits
		main_scene.show_credits()
	pass # Replace with function body.
