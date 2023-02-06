extends Node

var energy : int = 3
var stress : float = 0.0
var le_dialogue : description
var location : String = 'Room'
var stress_period_des : String = ''
var place_manager : PlaceManager
var choices : Choices

var current_dial_descr : String = ''

var picked_item : SceneItem = null
var inventory : Inventory

var _unused_connect_warning

var _unused_bool_warning

var stress_on : bool = false

var text_speed : float = 3

var text_menu_is_used : bool


func _ready():
	Fmod.play_one_shot("event:/Musics/Music", Skipp_Fmod_Errors)
	#Fmod.play_sound(Skipp_Fmod_Errors.sound_stress)
	

func is_goto(action : String):
	return action.substr(0, 5) == 'goto:'

func is_special(action : String):
	return action.substr(0, 8) == 'special:'
	
func is_element(action : String):
	return action.substr(0, 8) == 'element#'

func is_interpelation(action : String):
	return action.substr(0, 14) == 'interpelation#'

func is_disapear(action : String):
	return action.substr(0, 9) == 'disapear:'

func is_no_disapear(action : String):
	return action.substr(0, 12) == 'no_disapear:'

func is_visible(action : String):
	return action.substr(0, 8) == 'visible:'

func is_invisible(action : String):
	return action.substr(0, 11) == 'no_visible:'

func is_number_try(action : String):
	return action.substr(0, 11) == 'number_try:'

func is_limited_try(action : String):
	return action.substr(0, 12) == 'limited_try:'

func is_no_limited_try(action : String):
	return action.substr(0, 15) == 'no_limited_try:'

func is_usable(action : String):
	return action.substr(0, 10) == 'is_usable:'

func is_unusable(action : String):
	return action.substr(0, 13) == 'no_is_usable:'
	

func trigger_action(action : String, make_sound = true):
	if action == "":
		_unused_bool_warning = choices.set_description(action)
		return
	var is_already_set_description = false
	var what_action = action.split(',')
	var what_sub_action
	var what_sub_action_name
	var what_place
	var what_object
	for one_action in what_action:
		if is_goto(one_action):
			var where_goto = one_action.substr(5)
			if make_sound:
				if where_goto == 'Room':
					Fmod.play_one_shot("event:/Environment/Transition_Stairs", Skipp_Fmod_Errors)
				else:
					Fmod.play_one_shot("event:/Environment/Transition_Door", Skipp_Fmod_Errors)
			place_manager.go_to(where_goto)
		elif is_special(one_action):
			var what_special = one_action.split(':')
			if what_special[1] == 'radio':
				if OS.has_feature("standalone"):
					Fmod.play_one_shot("event:/Environment/Radio_On", Skipp_Fmod_Errors)
			elif what_special[1] == 'stress_off':
				GameState.stress = 30.00
			elif what_special[1] == 'music':
				if OS.has_feature("standalone"):
					Fmod.play_one_shot("event:/Environment/Radio_On", Skipp_Fmod_Errors)
					Fmod.play_one_shot("event:/Environment/Radio_Music", Skipp_Fmod_Errors)
		elif is_disapear(one_action) or is_usable(one_action) or is_visible(one_action) or is_limited_try(one_action):
			what_sub_action = one_action.split(':')
			what_sub_action_name = what_sub_action[0]
			what_sub_action.remove(0)
			what_place = what_sub_action[0]
			what_sub_action.remove(0)
			
			if what_place == "":
				what_object = place_manager.places[place_manager.get_child(0).name].elements
			else:
				what_object = place_manager.places[what_place].elements
			for sub_action in what_sub_action:
				what_object[sub_action][what_sub_action_name] = true
		elif is_no_disapear(one_action) or is_unusable(one_action) or is_invisible(one_action) or is_no_limited_try(one_action):
			what_sub_action = one_action.split(':')
			what_sub_action_name = what_sub_action[0].substr(3)
			what_sub_action.remove(0)
			what_place = what_sub_action[0]
			what_sub_action.remove(0)
			
			if what_place == "":
				what_object = place_manager.places[place_manager.get_child(0).name].elements
			else:
				what_object = place_manager.places[what_place].elements
			for sub_action in what_sub_action:
				what_object[sub_action][what_sub_action_name] = false
		elif is_number_try(one_action):
			what_sub_action = one_action.split(':')
			what_sub_action_name = what_sub_action[0].substr(3)
			what_sub_action.remove(0)
			what_place = what_sub_action[0]
			what_sub_action.remove(0)
			if what_place == "":
				what_object = place_manager.places[place_manager.get_child(0).name].elements
			else:
				what_object = place_manager.places[what_place].elements
			what_object[what_sub_action[0]][what_sub_action_name] = str2var(what_sub_action[1])
		elif is_element(one_action):
			var change_element = one_action.split('#')
			if change_element[1] == "":
				place_manager.places[place_manager.get_child(0).name].elements[change_element[2]]['inter'] = \
				   change_element[3]
			else:
				place_manager.places[change_element[1]].elements[change_element[2]]['inter'] = \
				   change_element[3]
		elif is_interpelation(one_action):
			var change_interpelation = one_action.split('#')
			if change_interpelation[1] == "":
				place_manager.places[place_manager.get_child(0).name].inter = \
				   change_interpelation[2]
			else:
				place_manager.places[change_interpelation[1]].inter = \
				   change_interpelation[2]
		else:
			_unused_bool_warning = choices.set_description(one_action)
			is_already_set_description = true
	if not is_already_set_description:
		_unused_bool_warning = choices.set_description("")


func reponse_cost_energy(action : String):
	
	if action == "":
		return 0
	
	var what_action = action.split(',')
	for one_action in what_action:
		if not is_goto(one_action) and not is_element(one_action) and \
		   not is_special(one_action) and not is_interpelation(one_action) and \
		   not is_no_disapear(one_action) and not is_disapear(one_action) and \
		   not is_usable(one_action) and not is_unusable(one_action) and \
		   not is_visible(one_action) and not is_invisible(one_action) and \
		   not is_limited_try(one_action) and not is_no_limited_try(one_action) and \
		   not is_number_try(one_action):
			if one_action == "":
				return 0
			return Interactions.lines[one_action].energie_add
	return 0


func add_item(item : SceneItem):
	inventory.add_item(item)

func text_apparing(current_object, speed = text_speed):
	var unit_of_char =  1.0 / current_object.text.length() / speed
	current_object.percent_visible += unit_of_char
func reset():
	energy = 3
	stress = 0.0
	picked_item = null
	stress_on = false
	place_manager.init()

func death():
	if GameState.stress >= 100.0:
		reset()
		place_manager.go_to('Death')
		_unused_bool_warning = choices.set_description("DesDeath")

func _process(_delta):
	if stress < 40.00 and stress_on:
		stress_on = false
	death()
	if stress >= 40.0 and stress < 100.0 and stress_on:
		stress += (0.0003 * stress)
		
	#Fmod.set_event_parameter_by_name(Skipp_Fmod_Errors.sound_stress, "Stress", stress)
	if picked_item != null:
		picked_item.position = picked_item.get_global_mouse_position()
