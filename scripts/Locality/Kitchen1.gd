extends Control

func update_room():
	GameState.place_manager.places['Room'].elements['door']['inter'] = 'goto:Hall2'
	pass

func init_room():
	var place = GameState.place_manager.places[name]
	place.elements = {
		'mother'         : { 'inter' : 'Des61',
						   'is_usable' : true,
						   'limited_try' : true,
						   'num_try' : 1,
						   'set_num_try' : false,
						   'disapear' : false,
						   'visible' : true, },
		'kitchen_door'   : { 'inter' : 'goto:Hall2',
						   'is_usable' : true,
						   'limited_try' : false,
						   'num_try' : 1,
						   'set_num_try' : false,
						   'disapear' : false,
						   'visible' : true, },
		'chocolat_small' : { 'inter' : 'Dial3',
						   'is_usable' : true,
						   'limited_try' : true,
						   'num_try' : 1,
						   'set_num_try' : false,
						   'disapear' : false,
						   'visible' : true, },
		'radio'          : { 'inter' : 'special:radio,Des6',
						   'is_usable' : true,
						   'limited_try' : false,
						   'num_try' : 1,
						   'set_num_try' : false,
						   'disapear' : false,
						   'visible' : true, },
		'trash_can'      : { 'inter' : 'Des8',
						   'is_usable' : true,
						   'limited_try' : false,
						   'num_try' : 1,
						   'set_num_try' : false,
						   'disapear' : false,
						   'visible' : true, },
		
	}
	place.inter = 'Dial2'

func _process(_delta):
	GameState.place_manager.set_all_object_parameters_on_scene(self)
