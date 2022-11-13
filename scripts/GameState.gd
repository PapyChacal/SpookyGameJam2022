extends Node

var energy : int = 3
var stress : float = 0.0
var le_dialogue : description
var location : String = 'Room'
var place_manager : PlaceManager

onready var sound_stress : int = Fmod.create_event_instance("event:/Musics/Stress_Ambient")

func _ready():
	Fmod.play_one_shot("event:/Musics/Music", self)
	Fmod.play_sound(sound_stress)

func _process(delta):
	Fmod.set_event_parameter_by_name(sound_stress, "Stress", stress)
