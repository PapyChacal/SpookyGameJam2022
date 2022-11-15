extends TextureProgress


func _ready():
	Fmod.play_one_shot_with_params("event:/Environment/Transition_Step", self, { 'Stress' : GameState.stress})
	pass
