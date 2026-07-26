extends MeshInstance3D
@onready var collision_shape = $Interactable/CollisionShape3D

@export var note_pages : Array[Texture2D]
@export var collision_area: CollisionShape3D

func _ready():
	collision_shape.shape.size.x = mesh.size.x * 1.05
	collision_shape.shape.size.z = mesh.size.y * 1.05


func disable_collision():
	collision_area.disabled = true

func enable_collision():
	collision_area.disabled = false


func handle_interaction() -> void:
	Globals.set_active_note(note_pages)
	Globals.hud_controller.set_hud(HudController.HudState.READING_NOTE)
