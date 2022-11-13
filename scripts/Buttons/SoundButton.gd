class_name SoundButton
extends Button

# Simple script for making buttons do a validation bleep
# For factorization

func _ready():
# warning-ignore:return_value_discarded
	connect("pressed", self, "validation_bleep")

func validation_bleep():
	Fmod.play_one_shot("event:/UI/Validate", self)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
