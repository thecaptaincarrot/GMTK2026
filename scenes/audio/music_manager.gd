extends Node

@onready var player := $"AudioStreamPlayer"

const MUSIC_PATH = "res://Audio/Music/"

func setSong(songName):
	player.stream = load(MUSIC_PATH + songName + ".wav")
	player.play()
