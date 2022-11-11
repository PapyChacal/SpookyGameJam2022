extends Control
class_name Choices
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal choice_made

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_choice1():
	emit_signal("choice_made", 1)
	
func _on_choice2():
	emit_signal("choice_made", 2)
	
func _on_choice3():
	emit_signal("choice_made", 3)

func _on_choice4():
	emit_signal("choice_made", 4)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
