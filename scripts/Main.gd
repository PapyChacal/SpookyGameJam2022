extends Node2D

onready var choices = $Choices

func _process(_delta):
	var d = GameState.le_dialogue
	if d != null \
	   and d.get('possible_reponses') == null \
	   and Input.is_action_just_released("ui_select"):
		Fmod.play_one_shot("event:/UI/Validate", self)
		choices.set_description(d.next)
