extends Control


func _ready():
	var place = GameState.place_manager.places[name]
	place.elements = {
		'mother'      : ''
	}
	place.inter = 'Dial2'
