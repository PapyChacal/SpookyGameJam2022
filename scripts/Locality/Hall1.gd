extends Node2D


func _ready():
	var place = GameState.place_manager.places[name]
	place.elements = {
		'brother' : ''
	}
	place.inter = 'Dial1'
