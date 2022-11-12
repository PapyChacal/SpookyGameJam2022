extends SoundButton
class_name QuitButton
# Self-explanatory ?

func _ready():
	connect("pressed", self, "quit")

func quit():
	get_tree().quit(0)
