@tool
extends Camera3D
class_name PlayerPositionOption

@export var collision_area: CollisionShape3D
@export var valid_neighbors:Array[PlayerPositionOption]
@export var valid_clickables: Array[Node3D]
@export var reverb_vector := Vector4(0, 0, 0, 0)

var game_room:GameRoom

@export_tool_button("Rotate 90 degrees") var rotate_action = rotate_90
@export var time_dilation_multiplier: float = 1

@onready var interactable = $Interactable

func _ready():
	if  Engine.is_editor_hint() == false:
		interactable.camera_area = true

func disable_collision():
	collision_area.disabled = true

func enable_collision():
	collision_area.disabled = false

func enable_neighbors():
	print(name)
	for n in valid_neighbors:
		n.enable_collision()
	for n in valid_clickables:
		n.enable_collision()
	Globals.enable_HUD_buttons.emit()

# each interactable object knows how to handle it's own interaction
func handle_interaction() -> void:
	assert(Globals.get_last_position(), "player should arrive from somewhere")
	assert(Globals.get_last_position().valid_neighbors.has(self) or Globals.get_last_position() == self, "not a valid neighbor")
	
	move_player_to_position()
	Globals.time_controller.set_time_multiplier(self.time_dilation_multiplier)
	if time_dilation_multiplier > 1:
		AudioPlayer.create_3D_audio_at_location(global_position,"TimeDilation","TimeDilation")
	else:
		AudioPlayer.stop_3d_audio("TimeDilation")

func move_player_to_position(tween_override = false):
	SignalBus.entedered_position_node.emit()
	var player = Globals.get_player()
	if player:
		game_room.disable_all_clickables()

		#sync the pseudo camera to the player camera
		#more can be added but I think this is a good starting point
		if(Globals.should_tween and tween_override == false):
			player.change_position(self.get_global_position(), Vector3(self.global_rotation.x, player.global_rotation.y, self.global_rotation.z), self.fov)
			AudioManager.QUEUED_SETUP_VECTOR = reverb_vector # audio manager
			await player.movement_finished
		else:
			player.change_position_instant(self.get_global_position(), Vector3(self.global_rotation.x, player.global_rotation.y, self.global_rotation.z), self.fov)
			AudioManager.QUEUED_SETUP_VECTOR = reverb_vector # audio manager
			AudioManager.REVERB_SETUP_VECTOR = reverb_vector # audio manager
		#this is here so that we are only clicking on valid neighbors for movement
		
		Globals.set_is_zoomed_in(false)
		Globals.set_last_position(self)
		enable_neighbors()


func rotate_90():
	rotation.y += PI/2
	if rotation.y >= 2 * PI: 
		rotation.y = 0  
