extends Node

var energy : int = 3
var stress : float = 0.0
var le_dialogue : description
var location : String = 'Room'
var place_manager : PlaceManager
var choices : Choices

var picked_item : SceneItem = null
var inventory : Inventory

var text_speed : float = 3.5

var text_menu_is_used : bool

onready var sound_stress : int = Fmod.create_event_instance("event:/Musics/Stress_Ambient")

func _ready():
	Fmod.play_one_shot("event:/Musics/Music", self)
	Fmod.play_sound(sound_stress)
	

func is_goto(action : String):
	return action.substr(0, 5) == 'goto:'

func trigger_action(action : String):
	if is_goto(action):
		place_manager.go_to(action.substr(5))
	else:
		choices.set_description(action)

func validate_interaction():
	choices.interaction_is_read()

func validate_question():
	choices.question_is_read()

func reponse_cost_energy(r : reponse):
	var action = r.next
	if is_goto(action) or action == "":
		return 0
	return Interactions.lines[action].energie_add

func add_item(item : SceneItem):
	inventory.add_item(item)

func text_apparing(current_object, speed = text_speed):
	var unit_of_char =  1.0 / current_object.text.length() / speed
	current_object.percent_visible += unit_of_char

func _process(_delta):
	Fmod.set_event_parameter_by_name(sound_stress, "Stress", stress)
	if picked_item != null:
		picked_item.position = picked_item.get_global_mouse_position()
