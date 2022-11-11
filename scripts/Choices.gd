extends Control
class_name Choices
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var le_dialogue : dialogue

signal choice_made

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_choice1():
	emit_signal("choice_made", le_dialogue.possible_reponses[0])
	
func _on_choice2():
	emit_signal("choice_made", le_dialogue.possible_reponses[1])
	
func _on_choice3():
	emit_signal("choice_made", le_dialogue.possible_reponses[2])

func _on_choice4():
	emit_signal("choice_made", le_dialogue.possible_reponses[3])
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _dialogue_to_screan(un_dialogue : dialogue):
	get_node("HBoxContainer/Dialog/RichTextLabel").text = un_dialogue.text
	get_node("HBoxContainer/GridContainer/Choice1").text = un_dialogue.possible_reponses[0]
	get_node("HBoxContainer/GridContainer/Choice2").text = un_dialogue.possible_reponses[1]
	get_node("HBoxContainer/GridContainer/Choice3").text = un_dialogue.possible_reponses[2]
	get_node("HBoxContainer/GridContainer/Choice4").text = un_dialogue.possible_reponses[3]
	le_dialogue = un_dialogue
	return
