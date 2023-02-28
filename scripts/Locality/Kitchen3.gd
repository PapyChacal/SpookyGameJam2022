extends Control

func update_room():
	pass

func init_room():
	var place = GameState.place_manager.places[name]
	place.elements = {
		's_radio'          : { 'inter' : 'special:radio',
						   'is_usable' : true,
						   'limited_try' : false,
						   'num_try' : 1,
						   'set_num_try' : false,
						   'disapear' : false,
						   'visible' : true, },
		's_trash_can'      : { 'inter' : 'Des8',
						   'is_usable' : true,
						   'limited_try' : false,
						   'num_try' : 1,
						   'set_num_try' : false,
						   'disapear' : false,
						   'visible' : true, },
		's_poele'          : { 'inter' : 'special:stress_off,is_usable:Kitchen2:poele,goto:Kitchen2',
						   'is_usable' : false,
						   'limited_try' : false,
						   'num_try' : 1,
						   'set_num_try' : false,
						   'disapear' : false,
						   'visible' : true, },
		
	}
	place.inter = 'Dial9'

func _process(_delta):
	GameState.place_manager.set_all_object_parameters_on_scene(self)
