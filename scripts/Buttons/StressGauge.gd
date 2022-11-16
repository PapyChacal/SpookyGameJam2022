extends TextureProgress


func _ready():
	Fmod.play_one_shot_with_params("event:/Environment/Transition_Step", Skipp_Fmod_Errors, { 'Stress' : GameState.stress})
	pass
