extends Control


func _ready():
	var place = GameState.place_manager.places[name]
	place.elements = {
		'door'       : 'goto:Hall1',
		'smartphone' : 'Dial12',
		'book'       : 'Dial13'
	}
