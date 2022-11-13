extends Control
class_name PlaceManager

var scenes : Dictionary = {
	'Room' : preload("res://scenes/Room.tscn")
}

var places : Dictionary = {
	'Room' : place.new()
}

signal set_description

func interact(name : String):
	# Démarrer interaction avec l'objet 'name'
	print('Interact with ', name)
	# Le nom de l'action à déclencher
	var action = places[GameState.location][name]
	emit_signal("set_description", action)

func _ready():
	GameState.place_manager = self
	go_to(GameState.location)

func go_to(place : String):
	GameState.location = place
	for c in get_children():
		remove_child(c)
		c.queue_free()
	add_child(scenes[place].instance())
