extends Button
class_name PlayButton

func _ready():
# warning-ignore:return_value_discarded
	connect("pressed", self, "play")

func play():
# warning-ignore:return_value_discarded
	Fmod.play_one_shot("event:/UI/Validate", Skipp_Fmod_Errors)
	Fmod.play_one_shot("event:/Environment/Transition_Step", Skipp_Fmod_Errors)
	Fmod.play_one_shot("event:/Environment/Ambiance", Skipp_Fmod_Errors)
	get_tree().change_scene('res://scenes/Main.tscn')
