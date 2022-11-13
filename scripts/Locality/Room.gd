extends Control


func _ready():
	GameState.place_manager.places[name] = {
		'computer'   : 'Des0',
		'door'       : 'Des0',
		'smartphone' : 'Dial12',
		'book'       : 'Dial13'
	}
	pass
