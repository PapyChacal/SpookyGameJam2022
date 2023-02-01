extends Control
class_name Choices

onready var buttons : Array = [
	$VBox/HBox/HBox/Choice1,
	$VBox/HBox/HBox/Choice2,
	$VBox/HBox/HBox/Choice3,
]
onready var texts : Array = [
	$VBox/HBox/HBox/Choice1/VBox/Text,
	$VBox/HBox/HBox/Choice2/VBox/Text,
	$VBox/HBox/HBox/Choice3/VBox/Text,
]
onready var main_text = $VBox/HBox/Dialog/VBox/Text
onready var person_speaking = $VBox/HBoxTop/Panel/Label
onready var npr_gauge = $VBox/VBoxContainer/NPRGauge
onready var npr_button = $VBox/VBoxContainer/NPRButton

export(float) var answer_time = 7.0

onready var timer : Timer = $Timer

signal choice_made

var launch_stress_des : bool = true

var is_question : bool = false
var nrep = 0
var cur_rep = 0
var question_read : bool = false
var interaction_question_on_screen : bool = true
var show_responses : bool = false
func _ready():
	GameState.choices = self
# warning-ignore:return_value_discarded
	timer.connect("timeout", npr_button, "emit_signal", ["pressed"])
	npr_button.connect("pressed", self, "_on_choice", [0])
	for i in range(buttons.size()):
		buttons[i].connect("pressed", self, "_on_choice", [i+1])

func _process(_delta):
	if $VBox/HBoxTop/Panel/Label.percent_visible < 1.0:
		GameState.text_apparing($VBox/HBoxTop/Panel/Label)
	elif $VBox/HBox/Dialog/VBox/Text.percent_visible < 1.0:
		GameState.text_apparing($VBox/HBox/Dialog/VBox/Text)
	else:
		interaction_question_on_screen = true

	if is_question and show_responses:
		if texts[cur_rep].percent_visible < 1.0 :
			GameState.text_apparing(texts[cur_rep])
			if texts[cur_rep].percent_visible >= 1.0 :
				var e = GameState.reponse_cost_energy(\
				GameState.le_dialogue.possible_reponses[cur_rep+1].next)
				buttons[cur_rep].get_node("Energy").visible = e
				   
				if GameState.energy <= 0 and e != 0 :
					buttons[cur_rep].set_disabled(true)
				else:
					buttons[cur_rep].set_disabled(false)
				if cur_rep < nrep:
					cur_rep += 1
		else:
			for cur_rep2 in range(0,nrep+1):
				var e = GameState.reponse_cost_energy(\
				GameState.le_dialogue.possible_reponses[cur_rep2+1].next)
				buttons[cur_rep2].get_node("Energy").visible = e
				   
				if GameState.energy <= 0 and e != 0 :
					buttons[cur_rep2].set_disabled(true)
				else:
					buttons[cur_rep2].set_disabled(false)
			$VBox/VBoxContainer/NPRButton.set_disabled(false)
			if timer.is_stopped():
				timer.start(answer_time)
			else:
				npr_gauge.value = timer.time_left / answer_time

func question_is_read():
	$VBox/HBoxTop/Panel/Label.percent_visible = 1.0
	$VBox/HBox/Dialog/VBox/Text.percent_visible = 1.0
	if interaction_question_on_screen :
		if show_responses:
			for text in texts:
				text.percent_visible = 1.0
		show_responses = true

func interaction_is_read():
	$VBox/HBoxTop/Panel/Label.percent_visible = 1.0
	$VBox/HBox/Dialog/VBox/Text.percent_visible = 1.0
	if interaction_question_on_screen :
		GameState.trigger_action(GameState.le_dialogue.next)

func _on_choice(choice : int):
	timer.stop()
	npr_gauge.value = 1.0
	var d = GameState.le_dialogue
	if d != null :
		if d is Interactions.dialogue_type:
			show_responses = false
			GameState.trigger_action(d.possible_reponses[choice].next)

func _on_say_nothing():
	Fmod.play_one_shot("event:/UI/Back", Skipp_Fmod_Errors)
	emit_signal("choice_made", 0)
	
func _on_choice1():
	Fmod.play_one_shot("event:/UI/Validate", Skipp_Fmod_Errors)
	emit_signal("choice_made", 1)
	
func _on_choice2():
	Fmod.play_one_shot("event:/UI/Validate", Skipp_Fmod_Errors)
	emit_signal("choice_made", 2)
	
func _on_choice3():
	Fmod.play_one_shot("event:/UI/Validate", Skipp_Fmod_Errors)
	emit_signal("choice_made", 3)
	
func set_description(id : String) -> bool:
	if GameState.stress_on and launch_stress_des:
		launch_stress_des = false
		GameState.trigger_action(GameState.stress_period_des)
		return true
	if not interaction_question_on_screen:
		return false
	timer.stop()
	npr_gauge.value = 1.0
	interaction_question_on_screen = false
	if id == "":
		GameState.current_dial_descr = ''
	if id == "" or GameState.stress >= 100:
		GameState.le_dialogue = null
		GameState.text_menu_is_used = false
		self.set_visible(false)
		return false
	var already_same_dial = GameState.current_dial_descr == id
	GameState.current_dial_descr = id
	var d : description = Interactions.lines[id]
	
	
	GameState.text_menu_is_used = true
	self.set_visible(true)
	if not already_same_dial:
		if d.energie_add > 0:
			Fmod.play_one_shot("event:/UI/Energy_Fill", Skipp_Fmod_Errors)
		elif d.energie_add < 0:
			Fmod.play_one_shot("event:/UI/Energy_Use", Skipp_Fmod_Errors)
		GameState.energy += d.energie_add
		GameState.stress += d.stress_add
# warning-ignore:narrowing_conversion
		GameState.energy = max(min(GameState.energy, 3), 0)
		GameState.stress = max(min(GameState.stress, 100), 0)
	GameState.le_dialogue = d
	main_text.text = d.text
	main_text.percent_visible = 0.0
	if d.personne_parlant != "":
		person_speaking.text = d.personne_parlant
		person_speaking.percent_visible = 0.0
		$VBox/HBoxTop/Panel.set_visible(true)
	else:
		$VBox/HBoxTop/Panel.set_visible(false)
	nrep = 0 if not d is Interactions.dialogue_type else \
			   d.possible_reponses.size() - 1
	is_question = nrep != 0
	#print(str(nrep))
	for i in range(nrep):
		buttons[i].set_reponse(d.possible_reponses[i+1])
		buttons[i].set_visible(true)
		buttons[i].set_disabled(true)
	for i in range(nrep, 3):
		buttons[i].set_visible(false)
	nrep -= 1
	if is_question:
		#Fmod.play_one_shot("event:/UI/Dialogue", Skipp_Fmod_Errors)
		$VBox/VBoxContainer/NPRButton.set_disabled(true)
		cur_rep = 0
	$VBox/VBoxContainer.set_visible(is_question)
	$VBox/HBox/HBox.set_visible(is_question)
	return true
