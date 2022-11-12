extends Control
class_name Choices

onready var buttons : Array = [
	$HBoxContainer/GridContainer/Choice1,
	$HBoxContainer/GridContainer/Choice2,
	$HBoxContainer/GridContainer/Choice3,
	$HBoxContainer/GridContainer/Choice4,
]

signal choice_made

func _ready():
	print(Interactions.lines["Dial1"])
	print(Interactions.lines["Dial1"] == null)
	set_description("Dial1")

func _on_choice(choice : int):
	var d = GameState.le_dialogue
	set_description(d.possible_reponses[choice].next)
	var c = GameState.le_dialogue
	GameState.energy += c.energie_add
	GameState.stress += c.stress_add

func _on_choice1():
	emit_signal("choice_made", 1)
	
func _on_choice2():
	emit_signal("choice_made", 2)
	
func _on_choice3():
	emit_signal("choice_made", 3)

func _on_choice4():
	emit_signal("choice_made", 4)
	
func set_description(id : String):
	if id == "":
		GameState.le_dialogue = null
		self.set_visible(false)
		return
	
	var d : description = Interactions.lines[id]
	GameState.le_dialogue = d
	$HBoxContainer/Dialog/Text.text = d.text
	var nrep = 0 if not d is Interactions.dialogue_type else \
			   d.possible_reponses.size() - 1 
	for i in range(nrep):
		buttons[i].text = d.possible_reponses[i+1].text
		buttons[i].set_visible(true)
	for i in range(nrep, 4):
		buttons[i].set_visible(false)
