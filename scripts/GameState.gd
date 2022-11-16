extends Node

var energy : int = 3
var stress : float = 0.0
var le_dialogue : description
var location : String = 'Room'
var place_manager : PlaceManager
var choices : Choices

var picked_item : SceneItem = null
var inventory : Inventory

var _unused_connect_warning

var text_speed : float = 3

var text_menu_is_used : bool

var toilet_whas_not_used : bool = true

var brother_is_not_here : bool = false

var brother_is_in_his_room : bool = false

var smartphone_whas_not_used : bool = true
var book_whas_not_used : bool = true

func _ready():
	Fmod.play_one_shot("event:/Musics/Music", Skipp_Fmod_Errors)
	#Fmod.play_sound(Skipp_Fmod_Errors.sound_stress)
	

func is_goto(action : String):
	return action.substr(0, 5) == 'goto:'

func is_special(action : String):
	return action.substr(0, 8) == 'special:'
	
func is_element(action : String):
	return action.substr(0, 8) == 'element#'

func trigger_action(action : String, make_sound = true):
	if is_goto(action):
		var where_goto = action.substr(5)
		if make_sound:
			if where_goto == 'Room':
				Fmod.play_one_shot("event:/Environment/Transition_Stairs", Skipp_Fmod_Errors)
			else:
				Fmod.play_one_shot("event:/Environment/Transition_Door", Skipp_Fmod_Errors)
		place_manager.go_to(where_goto)
	elif is_special(action):
		var what_special = action.substr(8)
		if what_special == 'toilet':
			#print('have toilet')
			toilet_whas_not_used = false
			choices.set_description("")
		elif what_special.substr(0,4) == 'book':
			book_whas_not_used = false
			choices.set_description("")
		elif what_special.substr(0,10) == 'smartphone':
			smartphone_whas_not_used = false
			choices.set_description("")
		elif what_special.substr(0,6) == 'radio:':
			Fmod.play_one_shot("event:/Environment/Radio_On", Skipp_Fmod_Errors)
			if what_special.substr(6,6) == 'music:':
				Fmod.play_one_shot("event:/Environment/Radio_Music", Skipp_Fmod_Errors)
				choices.set_description(what_special.substr(12))
			else:
				choices.set_description(what_special.substr(6))
		elif what_special.substr(0,16) == 'brother_disapear':
			brother_is_not_here = true
			place_manager.get_child(0).get_node("brother").must_disapear = true
			place_manager.get_child(0).get_node("brother").visible = false
			place_manager.get_child(0).get_node("brother_door_enter").is_usable = true
			choices.set_description("")
		elif what_special.substr(0,14) == 'brother_apear:':
			brother_is_in_his_room = true
			place_manager.get_child(0).get_node("brother").visible = true
			place_manager.get_child(0).get_node("brother").must_disapear = false
			choices.set_description(what_special.substr(14))
	elif is_element(action):
		var what_element : String = action.substr(8)
		var change_element = what_element.split('#')
		place_manager.places[place_manager.get_child(0).name].elements[change_element[0]] = \
		   change_element[1]
		trigger_action(change_element[2])
		
	else:
		choices.set_description(action)

func validate_interaction():
	choices.interaction_is_read()

func validate_question():
	choices.question_is_read()

func reponse_cost_energy(r : reponse):
	var action = r.next
	if is_goto(action) or is_special(action) or is_element(action) or action == "":
		return 0
	return Interactions.lines[action].energie_add

func add_item(item : SceneItem):
	inventory.add_item(item)

func text_apparing(current_object, speed = text_speed):
	var unit_of_char =  1.0 / current_object.text.length() / speed
	current_object.percent_visible += unit_of_char

func _process(_delta):
	#Fmod.set_event_parameter_by_name(Skipp_Fmod_Errors.sound_stress, "Stress", stress)
	if picked_item != null:
		picked_item.position = picked_item.get_global_mouse_position()
