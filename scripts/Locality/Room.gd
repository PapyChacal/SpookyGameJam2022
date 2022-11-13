extends Control


func _ready():
	GameState.place_manager.places[name] = {
		'door'       : 'goto:Hall1',
		'smartphone' : 'Dial12',
		'book'       : 'Dial13'
	}
	pass
