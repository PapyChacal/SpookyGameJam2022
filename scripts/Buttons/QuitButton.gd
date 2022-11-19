extends SoundButton
class_name QuitButton
# Self-explanatory ?

func _ready():
	GameState._unused_connect_warning = connect("pressed", self, "quit")

func quit():
	get_tree().quit(0)
