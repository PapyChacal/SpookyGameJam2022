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

var _unused_bool_warning

var not_already_stress_on_1 : bool = true

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
	return action.substr(0, 8) == 'element:'

func is_interpelation(action : String):
	return action.substr(0, 14) == 'interpelation:'

func is_apear(action : String):
	return action.substr(0, 6) == 'apear:'

func is_disapear(action : String):
	return action.substr(0, 9) == 'disapear:'

func is_usable(action : String):
	return action.substr(0, 7) == 'usable:'

func is_unusable(action : String):
	return action.substr(0, 9) == 'unusable:'
	

func trigger_action(action : String, make_sound = true):
	if action == "":
		_unused_bool_warning = choices.set_description(action)
		return
	var is_already_set_description = false
	var what_action = action.split(',')
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
			if what_special[1] == 'toilet':
				toilet_whas_not_used = false
			elif what_special[1] == 'book':
				book_whas_not_used = false
			elif what_special[1] == 'smartphone':
				smartphone_whas_not_used = false
			elif what_special[1] == 'radio':
				if OS.has_feature("standalone"):
					Fmod.play_one_shot("event:/Environment/Radio_On", Skipp_Fmod_Errors)
			elif what_special[1] == 'music':
				if OS.has_feature("standalone"):
					Fmod.play_one_shot("event:/Environment/Radio_On", Skipp_Fmod_Errors)
					Fmod.play_one_shot("event:/Environment/Radio_Music", Skipp_Fmod_Errors)
		elif is_apear(one_action):
			var what_apear = one_action.split(':')
			what_apear.remove(0)
			for apear in what_apear:
				place_manager.get_child(0).get_node(apear).visible = true
		elif is_disapear(one_action):
			var what_disapear = one_action.split(':')
			what_disapear.remove(0)
			for disapear in what_disapear:
				place_manager.get_child(0).get_node(disapear).visible = false
		elif is_usable(one_action):
			var what_usable = one_action.split(':')
			what_usable.remove(0)
			for usable in what_usable:
				place_manager.get_child(0).get_node(usable).is_usable = true
		elif is_unusable(one_action):
			var what_unusable = one_action.split(':')
			what_unusable.remove(0)
			for unusable in what_unusable:
				place_manager.get_child(0).get_node(unusable).is_usable = false
		elif is_element(one_action):
			var change_element = one_action.split(':')
			if change_element[1] == "":
				place_manager.places[place_manager.get_child(0).name].elements[change_element[2]] = \
				   change_element[3]
			else:
				place_manager.places[change_element[1]].elements[change_element[2]] = \
				   change_element[3]
		elif is_interpelation(one_action):
			var change_interpelation = one_action.split(':')
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
		   not is_apear(one_action) and not is_disapear(one_action) and \
		   not is_usable(one_action) and not is_unusable(one_action):
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
	toilet_whas_not_used = true
	brother_is_here = true
	brother_is_in_his_room = false
	smartphone_whas_not_used = true
	book_whas_not_used = true
	not_already_stress_on_1 = true
	place_manager.init()

func death():
	if GameState.stress >= 100.0:
		reset()
		place_manager.go_to('Death')
		_unused_bool_warning = choices.set_description("DesDeath")

func _process(_delta):
	#Fmod.set_event_parameter_by_name(Skipp_Fmod_Errors.sound_stress, "Stress", stress)
	if picked_item != null:
		picked_item.position = picked_item.get_global_mouse_position()
