extends Node2D


func _ready():
	var place = GameState.place_manager.places[name]
	place.elements = {
		'brother'      : '',
		'staircase'    : 'goto:Room',
		'toilet'       : 'Des5',
		'plant'        : 'Des4',
		'door_kitchen' : ''
	}
	place.inter = 'Dial1'
