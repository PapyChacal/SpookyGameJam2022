extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_choice_made(choice : reponse):
	print("Chosen ", choice)
	pass # Replace with function body.


func _affiche_choice(var d : dialogue):
	get_node("Choices")._choice_to_screan(d)
