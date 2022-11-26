extends Control

func update_room():
	GameState.place_manager.places['Room'].elements['door'] = 'goto:Hall2'
	pass

func init_room():
	var place = GameState.place_manager.places[name]
	place.elements = {
		'mother'         : 'Des61',
		'kitchen_door'   : 'goto:Hall2',
		'chocolat_small' : 'Dial3',
		'radio'          : 'special:radio::Des6',
		'trash_can'      : 'Des8'
		
	}
	place.inter = 'Dial2'
