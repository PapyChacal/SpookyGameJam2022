extends Control

func update_room():
	pass

func init_room():
	var place = GameState.place_manager.places[name]
	place.elements = {
		'door'       : { 'inter' : 'goto:Hall1',
						   'is_usable' : true,
						   'limited_try' : false,
						   'num_try' : 1,
						   'set_num_try' : false,
						   'disapear' : false,
						   'visible' : true, },
		'smartphone' : { 'inter' : 'Dial12',
						   'is_usable' : true,
						   'limited_try' : false,
						   'num_try' : 1,
						   'set_num_try' : false,
						   'disapear' : false,
						   'visible' : true, },
		'book'       : { 'inter' : 'Dial13',
						   'is_usable' : true,
						   'limited_try' : false,
						   'num_try' : 1,
						   'set_num_try' : false,
						   'disapear' : false,
						   'visible' : true, },
		'computer'   : { 'inter' : 'Des31',
						   'is_usable' : true,
						   'limited_try' : false,
						   'num_try' : 1,
						   'set_num_try' : false,
						   'disapear' : false,
						   'visible' : true, },
	}
	place.inter = 'Des00'

func _process(_delta):
	GameState.place_manager.set_all_object_parameters_on_scene(self)
