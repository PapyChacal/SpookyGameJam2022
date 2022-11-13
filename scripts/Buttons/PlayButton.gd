extends SoundButton
class_name PlayButton

func _ready():
# warning-ignore:return_value_discarded
	connect("pressed", self, "play")

func play():
# warning-ignore:return_value_discarded
	get_tree().change_scene('res://scenes/Main.tscn')
