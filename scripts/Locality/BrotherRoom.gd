extends Control

func update_room():
	$brother.visible = GameState.brother_is_in_his_room
	pass

func init_room():
	var place = GameState.place_manager.places[name]
	place.elements = {
		'brother'      : '',
		'magazine'     : 'Dial14',
		'trash_can'    : 'Des8',
		'football'     : '',
		'brother_door_go_out' : 'goto:Hall2',
	}
	place.inter = ''
