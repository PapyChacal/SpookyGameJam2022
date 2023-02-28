extends Control

onready var scenes : Dictionary = {
	'Room'     : preload("res://scenes/Room.tscn"),
	'Hall1'    : preload("res://scenes/Hall1.tscn"),
	'BrotherRoom' : preload("res://scenes/BrotherRoom.tscn"),
	'Hall2'    : preload("res://scenes/Hall2.tscn"),
	'Kitchen1' : preload("res://scenes/Kitchen1.tscn"),
	'Death'       : preload("res://scenes/Death.tscn"),
	'Hall3'    : preload("res://scenes/Hall3.tscn"),
	'Kitchen2' : preload("res://scenes/Kitchen2.tscn"),
	'Hall4'    : preload("res://scenes/Hall4.tscn"),
	'Kitchen3' : preload("res://scenes/Kitchen3.tscn"),
}

onready var places : Dictionary = {
	'Room' : place.new(),
	'Hall1': place.new(),
	'BrotherRoom': place.new(),
	'Hall2': place.new(),
	'Kitchen1': place.new(),
	'Death' : place.new(),
	'Hall3': place.new(),
	'Kitchen2': place.new(),
	'Hall4': place.new(),
	'Kitchen3': place.new(),
}

signal trigger_action

func interact(name : String):
	# Démarrer interaction avec l'objet 'name'
#	print('PM: Interact with ', name)
	# Le nom de l'action à déclencher
	var action = places[GameState.location].elements[name]['inter']
#	print('action: ', action)
	emit_signal("trigger_action", action)

func _ready():
	GameState._unused_connect_warning = connect("trigger_action", GameState, "trigger_action")
	GameState.place_manager = self
	init()

func init():
	for p in scenes.values():
		var inst = p.instance()
		inst.init_room()
		inst.queue_free()

func go_to(place : String):
	GameState.location = place
	var inst = scenes[place].instance()
	inst.update_room()
	for c in get_children():
		remove_child(c)
		c.queue_free()
	add_child(inst)
	var interpelation = places[place].inter
	if (not GameState.stress_on) and GameState.current_dial_descr != '' and interpelation != '':
		interpelation = GameState.current_dial_descr
	
	GameState.trigger_action(interpelation)

func set_all_object_parameters_on_scene(scene : Control):
	for object in scene.get_children():
		if object.get_class() == "ElementSpriteBase":
			set_object_parameters(object, places[scene.name].elements[object.name])

func set_object_parameters(object : ElementSpriteBase, parameters : Dictionary):
	if object.is_usable != parameters['is_usable']:
		object.is_usable = parameters['is_usable']
	
	if object.has_limited_trys != parameters['limited_try']:
		object.has_limited_trys = parameters['limited_try']
	
	if parameters['num_try'] != 0 and object.number_of_try == 0:
		parameters['num_try'] = 0
	
	if parameters['set_num_try']:
		object.number_of_try = parameters['num_try']
		parameters['set_num_try'] = false
	
	if object.must_disapear != parameters['disapear']:
		object.must_disapear = parameters['disapear']
	
	if object.visible != parameters['visible']:
		object.visible = parameters['visible']
