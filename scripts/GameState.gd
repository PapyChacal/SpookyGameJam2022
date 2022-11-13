extends Node

var energy : int = 3
var stress : float = 0.0
var le_dialogue : description
var location : String = 'Room'
var place_manager : PlaceManager
var choices : Choices

onready var sound_stress : int = Fmod.create_event_instance("event:/Musics/Stress_Ambient")

func _ready():
	Fmod.play_one_shot("event:/Musics/Music", self)
	Fmod.play_sound(sound_stress)

func trigger_action(action : String):
	if action.substr(0, 5) == 'goto:':
		place_manager.go_to(action.substr(5))
	else:
		choices.set_description(action)

func _process(_delta):
	Fmod.set_event_parameter_by_name(sound_stress, "Stress", stress)
