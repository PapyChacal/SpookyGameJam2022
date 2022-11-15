extends Control

func update_room():
	$toilet.is_usable = GameState.toilet_whas_not_used

func init_room():
	var place = GameState.place_manager.places[name]
	place.elements = {
		'brother'      : 'Dial6',
		'staircase'    : 'goto:Room',
		'toilet'       : 'Des5',
		'plant'        : 'Des4',
		'door_kitchen' : ''
	}
	place.inter = ''
