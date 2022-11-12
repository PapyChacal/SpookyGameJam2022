extends Node2D

onready var choices = $Choices

func _ready():
	choices.set_description("Dial3")

func _process(_delta):
	var d = GameState.le_dialogue
	if d != null \
	   and d.get('possible_reponses') == null \
	   and Input.is_action_just_released("ui_select"):
		Fmod.play_one_shot("event:/UI/Validate", self)
		choices.set_description(d.next)

func _on_choice_made(choice : reponse):
	print("Chosen ", choice)
	pass # Replace with function body.


func _affiche_choice(var d : dialogue):
	get_node("Choices")._choice_to_screan(d)
