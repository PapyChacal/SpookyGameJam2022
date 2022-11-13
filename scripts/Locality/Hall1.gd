extends Node2D


func _ready():
	GameState.place_manager.places[name] = {
		'brother' : ''
	}
	pass
