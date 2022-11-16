extends Node

onready var choices = $Choices

func _ready():
	GameState.trigger_action('goto:Room', false)

func _process(_delta):
	var d = GameState.le_dialogue
	if d != null \
	   and Input.is_action_just_released("ui_select"):
		if d.get('possible_reponses') == null:
			if d.next != "" :
				Fmod.play_one_shot("event:/UI/Validate", Skipp_Fmod_Errors)
				GameState.trigger_action(d.next)
			else :
				GameState.validate_interaction()
		else:
			GameState.validate_question()
