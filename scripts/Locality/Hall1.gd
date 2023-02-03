extends Control

func update_room():
	pass

func init_room():
	var place = GameState.place_manager.places[name]
	place.elements = {
		'brother'      : { 'inter' : '',
						   'is_usable' : true,
						   'limited_try' : true,
						   'num_try' : 1,
						   'set_num_try' : false,
						   'disapear' : false,
						   'visible' : true },
		'staircase'    : { 'inter' : 'goto:Room',
						   'is_usable' : true,
						   'limited_try' : false,
						   'num_try' : 1,
						   'set_num_try' : false,
						   'disapear' : false,
						   'visible' : true, },
		'toilet'       : { 'inter' : 'Des5',
						   'is_usable' : true,
						   'limited_try' : true,
						   'num_try' : 1,
						   'set_num_try' : false,
						   'disapear' : false,
						   'visible' : true, },
		'plant'        : { 'inter' : 'Des4',
						   'is_usable' : true,
						   'limited_try' : false,
						   'num_try' : 1,
						   'set_num_try' : false,
						   'disapear' : false,
						   'visible' : true, },
		'door_kitchen' : { 'inter' : 'goto:Kitchen1',
						   'is_usable' : true,
						   'limited_try' : false,
						   'num_try' : 1,
						   'set_num_try' : false,
						   'disapear' : false,
						   'visible' : true, },
	}
	place.inter = 'Dial1'


func _process(_delta):
	if GameState.energy == 3 and GameState.place_manager.places[name].elements['toilet']['is_usable']:
		GameState.place_manager.places[name].elements['toilet']['is_usable'] = false
	elif GameState.energy < 3 and not GameState.place_manager.places[name].elements['toilet']['is_usable']:
		GameState.place_manager.places[name].elements['toilet']['is_usable'] = true
	GameState.place_manager.set_all_object_parameters_on_scene(self)
	
	if GameState.place_manager.places[name].elements['toilet']['num_try'] == 0 and\
	   $toilet.number_of_try != 0:
		GameState.place_manager.places[name].elements['toilet']['set_num_try'] = true
		GameState.place_manager.set_object_parameters($toilet,
			GameState.place_manager.places[name].elements['toilet'])
	
