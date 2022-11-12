extends SoundButton
class_name PlayButton

func _ready():
	connect("pressed", self, "play")

func play():
	get_tree().change_scene('res://scenes/Chambre.tscn')
