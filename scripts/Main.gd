extends Node

onready var choices = $Choices

func _ready():
	GameState.trigger_action('goto:Room')

func _process(_delta):
	var d = GameState.le_dialogue
	if d != null \
	   and d.get('possible_reponses') == null \
	   and Input.is_action_just_released("ui_select"):
		Fmod.play_one_shot("event:/UI/Validate", self)
		GameState.trigger_action(d.next)
