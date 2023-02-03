extends Node

onready var choices = $Choices

func _ready():
	GameState.trigger_action('goto:' + GameState.location, false)
	set_process(true)

func _input(_event):
	if Input.is_action_pressed("ui_cancel"):
		Fmod.play_one_shot("event:/UI/Validate", Skipp_Fmod_Errors)
		Fmod.play_one_shot("event:/Environment/Transition_Step", Skipp_Fmod_Errors)
		GameState._unused_connect_warning = get_tree().change_scene("res://scenes/MainMenu.tscn")

func _process(_delta):
	var d = GameState.le_dialogue
	if d != null \
	   and Input.is_action_just_released("ui_select"):
		Fmod.play_one_shot("event:/UI/Validate", Skipp_Fmod_Errors)
		if d.get('possible_reponses') == null:
			GameState.choices.interaction_is_read()
			if d.next != "" :
				GameState.trigger_action(d.next)
		else:
			GameState.choices.question_is_read()
