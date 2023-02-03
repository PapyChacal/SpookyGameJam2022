extends Control

func update_room():
	GameState.place_manager.places['Room'].elements['door']['inter'] = 'goto:Hall2'
	pass

func init_room():
	var place = GameState.place_manager.places[name]
	place.elements = {
		'mother'         : GameState.place_manager.places['Kitchen1'].elements['mother'],
		'kitchen_door'   : { 'inter' : 'goto:Hall4',
						   'is_usable' : true,
						   'limited_try' : false,
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
		'poele'          : { 'inter' : '',
						   'is_usable' : false,
						   'limited_try' : false,
						   'num_try' : 1,
						   'set_num_try' : false,
						   'disapear' : false,
						   'visible' : true, },
		
	}
	place.inter = 'Dial8'

func _process(_delta):
	if GameState.stress >= 40.00 and not GameState.stress_on:
		GameState.stress_period_des = 'Des11'
		GameState.stress_on = true
	GameState.place_manager.set_all_object_parameters_on_scene(self)
