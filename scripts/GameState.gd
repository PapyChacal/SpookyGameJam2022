extends Node

var energy : int = 3
var stress : float = 0.0
var le_dialogue : description
var location : String = 'Room'
var place_manager : PlaceManager
var choices : Choices

var current_dial_descr : String = ''

var picked_item : SceneItem = null
var inventory : Inventory

var _unused_connect_warning

var text_speed : float = 3

var text_menu_is_used : bool

var toilet_whas_not_used : bool = true

var brother_is_here : bool = true

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

func is_interpelation(action : String):
	return action.substr(0, 14) == 'interpelation$'

func is_apear_disapear(action : String):
	return action.substr(0, 15) == 'apear_disapear*'

func is_usable_unusable(action : String):
	return action.substr(0, 16) == 'usable_unusable!'
	

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
		var what_special = action.split(':')
		if what_special[1] == 'toilet':
			toilet_whas_not_used = false
		elif what_special[1] == 'book':
			book_whas_not_used = false
		elif what_special[1] == 'smartphone':
			smartphone_whas_not_used = false
		elif what_special[1] == 'radio':
			Fmod.play_one_shot("event:/Environment/Radio_On", Skipp_Fmod_Errors)
			if what_special[2] == 'music':
				Fmod.play_one_shot("event:/Environment/Radio_Music", Skipp_Fmod_Errors)
		trigger_action(what_special[3])
	elif is_apear_disapear(action):
		var what_apear_disapear = action.split('*')
		var what_apear
		var what_disapear
		if what_apear_disapear[2] != "":
			what_apear = what_apear_disapear[2].split(',')
		if what_apear_disapear[3] != "":
			what_disapear = what_apear_disapear[3].split(',')
		if what_apear_disapear[1] == "":
			if what_apear_disapear[2] != "":
				for apear in what_apear:
					place_manager.get_child(0).get_node(apear).visible = true
			if what_apear_disapear[3] != "":
				for disapear in what_disapear:
					place_manager.get_child(0).get_node(disapear).visible = false
		trigger_action(what_apear_disapear[4])
	elif is_usable_unusable(action):
		var what_usable_unusable = action.split('!')
		var what_usable
		var what_unusable
		if what_usable_unusable[2] != "":
			what_usable = what_usable_unusable[2].split(',')
		if what_usable_unusable[3] != "":
			what_unusable = what_usable_unusable[3].split(',')
		if what_usable_unusable[1] == "":
			if what_usable_unusable[2] != "":
				for usable in what_usable:
					place_manager.get_child(0).get_node(usable).is_usable = true
			if what_usable_unusable[3] != "":
				for unusable in what_unusable:
					place_manager.get_child(0).get_node(unusable).is_usable = false
		trigger_action(what_usable_unusable[4])
	elif is_element(action):
		var change_element = action.split('#')
		if change_element[1] == "":
			place_manager.places[place_manager.get_child(0).name].elements[change_element[2]] = \
			   change_element[3]
		else:
			place_manager.places[change_element[1]].elements[change_element[2]] = \
			   change_element[3]
		trigger_action(change_element[4])
	elif is_interpelation(action):
		var change_interpelation = action.split('$')
		if change_interpelation[1] == "":
			place_manager.places[place_manager.get_child(0).name].inter = \
			   change_interpelation[2]
			print(place_manager.places[place_manager.get_child(0).name].inter)
		else:
			place_manager.places[change_interpelation[1]].inter = \
			   change_interpelation[2]
		trigger_action(change_interpelation[3])
	else:
		choices.set_description(action)



func reponse_cost_energy(action : String):
	
	if is_goto(action) or action == "":
		return 0
	
	if is_element(action):
		var change_element = action.split('#')
		action = change_element[4]
		return reponse_cost_energy(action)
	elif is_special(action):
		var what_special = action.split(':')
		action = what_special[3]
		return reponse_cost_energy(action)
	elif is_interpelation(action):
		var change_interpelation = action.split('$')
		action = change_interpelation[3]
		return reponse_cost_energy(action)
	elif is_apear_disapear(action):
		var what_apear_disapear = action.split('*')
		action = what_apear_disapear[4]
		return reponse_cost_energy(action)
	elif is_usable_unusable(action):
		var what_usable_unusable = action.split('!')
		action = what_usable_unusable[4]
		return reponse_cost_energy(action)
	
	return Interactions.lines[action].energie_add

func add_item(item : SceneItem):
	inventory.add_item(item)

func text_apparing(current_object, speed = text_speed):
	var unit_of_char =  1.0 / current_object.text.length() / speed
	current_object.percent_visible += unit_of_char
func reset():
	energy = 3
	stress = 0.0
	picked_item = null
	toilet_whas_not_used = true
	brother_is_here = true
	brother_is_in_his_room = false
	smartphone_whas_not_used = true
	book_whas_not_used = true
	place_manager.init()

func death():
	if GameState.stress >= 100:
		reset()
		place_manager.go_to('Death')
		choices.set_description("DesDeath")

func _process(_delta):
	death()
	#Fmod.set_event_parameter_by_name(Skipp_Fmod_Errors.sound_stress, "Stress", stress)
	if picked_item != null:
		picked_item.position = picked_item.get_global_mouse_position()
