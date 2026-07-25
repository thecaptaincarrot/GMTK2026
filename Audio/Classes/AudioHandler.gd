extends Node

var sound_effect_dict = {}
var game_node : GameWorld

const AUDIO_PATH = "res://Audio/"

func _ready():
	#go  through all files in the Items folder (including subfolders) to find any Items
	#Register those items in the item_registry
	#TODO: Make this work in an exported version of the game
	var dir = DirAccess.open(AUDIO_PATH)
	#Just going to iterate through all resources in ITEM_PATH
	#If that is too unwieldly, then we will have to change IDs to be a little more specific
	var directories = [""]
	directories.append_array(dir.get_directories())
	var search_directories = dir.get_directories()
	while !search_directories.is_empty():
		var current_dir = search_directories[0]
		var new_dir = DirAccess.open(AUDIO_PATH + current_dir)
		for directory in new_dir.get_directories():
			var directory_path = current_dir + "/" + directory
			directories.append(directory_path)
			search_directories.append(directory_path)
		search_directories.remove_at(0)
	
	#Get all resource files
	for sub_dir in directories:
		dir = DirAccess.open(AUDIO_PATH + "/" + sub_dir)
		for file_name in dir.get_files():
			if file_name.ends_with(".remap"):
				file_name = file_name.trim_suffix(".remap")
			if file_name.ends_with(".tres"):
				if ResourceLoader.load(AUDIO_PATH + "/" + sub_dir + "/" + file_name) is SoundEffect:
					var resource : SoundEffect = ResourceLoader.load(AUDIO_PATH + "/" + sub_dir + "/" + file_name)
					sound_effect_dict[resource.ID] = resource


func create_3D_audio_at_location(sound_posiition : Vector3, effect_ids : Array):
	var effect_id = effect_ids.pick_random()
	if sound_effect_dict.has(effect_id):
		var sound_effect_settings = sound_effect_dict[effect_id]
		if sound_effect_settings.has_open_limit() and game_node:
			sound_effect_settings.increment_audio_count(1)
			var new_3d_player = AudioStreamPlayer3D.new()
			game_node.add_child(new_3d_player)
			
			#TODO: Check if the sound is close enough to the player to matter
			new_3d_player.position = sound_posiition
			new_3d_player.stream = sound_effect_settings.sound_effect
			new_3d_player.stream.bus = "gameSfx"
			new_3d_player.volume_db = sound_effect_settings.volume
			new_3d_player.pitch_scale = sound_effect_settings.pitch_scale
			new_3d_player.pitch_scale += randf_range(-sound_effect_settings.pitch_randomness, sound_effect_settings.pitch_randomness)
			new_3d_player.finished.connect(sound_effect_settings.on_audio_finished)
			new_3d_player.finished.connect(new_3d_player.queue_free)
			
			new_3d_player.play()
	else:
		push_error("NO SUCH SOUND EFFECT AS ", effect_id)

func create_audio(effect_id):
	if sound_effect_dict.has(effect_id):
		var sound_effect_settings = sound_effect_dict[effect_id]
		if sound_effect_settings.has_open_limit() and game_node:
			sound_effect_settings.increment_audio_count(1)
			var new_3d_player = AudioStreamPlayer.new()
			game_node.add_child(new_3d_player)
			
			#TODO: Check if the sound is close enough to the player to matter
			new_3d_player.bus = "gameSfx"
			new_3d_player.stream = sound_effect_settings.sound_effect.pick_random()
			new_3d_player.volume_db = sound_effect_settings.volume
			new_3d_player.pitch_scale = sound_effect_settings.pitch_scale
			new_3d_player.pitch_scale += randf_range(-sound_effect_settings.pitch_randomness, sound_effect_settings.pitch_randomness)
			new_3d_player.finished.connect(sound_effect_settings.on_audio_finished)
			new_3d_player.finished.connect(new_3d_player.queue_free)
			
			new_3d_player.play()
	else:
		push_error("NO SUCH SOUND EFFECT AS ", effect_id)
