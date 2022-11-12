extends Control
class_name Choices

var le_dialogue : description
onready var buttons : Array = [
	$HBoxContainer/GridContainer/Choice1,
	$HBoxContainer/GridContainer/Choice2,
	$HBoxContainer/GridContainer/Choice3,
	$HBoxContainer/GridContainer/Choice4,
]

signal choice_made

func _ready():
	print(Interactions.lines["Description 1.1"])
	print(Interactions.lines["Description 1.1"] == null)
	set_description("Description 1.1")

func _process(_delta):
	if (not le_dialogue is Interactions.dialogue_type) \
	   and le_dialogue != null \
	   and Input.is_action_just_released("ui_select"):
		Fmod.play_one_shot("event:/UI/Validate", self)
		set_description(le_dialogue.next)

func _on_choice(choice : int):
	set_description(le_dialogue.possible_reponses[choice].next)

func _on_choice1():
	emit_signal("choice_made", 0)
	
func _on_choice2():
	emit_signal("choice_made", 1)
	
func _on_choice3():
	emit_signal("choice_made", 2)

func _on_choice4():
	emit_signal("choice_made", 3)
	
func set_description(id : String):
	if id == "":
		le_dialogue = null
		self.set_visible(false)
		return
	
	var d : description = Interactions.lines[id]
	le_dialogue = d
	$HBoxContainer/Dialog/Text.text = d.text
	var nrep = 0 if not d is Interactions.dialogue_type else \
			   d.possible_reponses.size() 
	for i in range(nrep):
		buttons[i].text = d.possible_reponses[i].text
		buttons[i].set_visible(true)
	for i in range(nrep, 4):
		buttons[i].set_visible(false)
