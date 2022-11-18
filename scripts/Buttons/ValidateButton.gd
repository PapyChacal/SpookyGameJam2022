extends SoundButton
class_name ValidateButton

func _init():
	sound = "event:/UI/Validate"

func _ready():
# warning-ignore:return_value_discarded
	connect("pressed", self, "play")

func play():
	get_tree().quit()
