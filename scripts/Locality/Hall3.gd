extends Control

func update_room():
	pass

func init_room():
	var place = GameState.place_manager.places[name]
	place.elements = {
		'door_kitchen' : { 'inter' : 'goto:Kitchen3',
						   'is_usable' : true,
						   'limited_try' : false,
						   'num_try' : 1,
						   'set_num_try' : false,
						   'disapear' : false,
						   'visible' : true, },
	}
	place.inter = ''

func _process(_delta):
	GameState.place_manager.set_all_object_parameters_on_scene(self)
