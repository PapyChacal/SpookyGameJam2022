extends Control
class_name PlaceManager

var scenes : Dictionary = {
	'Room' : preload("res://scenes/Room.tscn")
}

var places : Dictionary = {
	'Room' : place.new()
}

signal trigger_action

func interact(name : String):
	# Démarrer interaction avec l'objet 'name'
	print('PM: Interact with ', name)
	# Le nom de l'action à déclencher
	var action = places[GameState.location][name]
	print('action: ', action)
	emit_signal("trigger_action", action)

func _ready():
	connect("trigger_action", GameState, "trigger_action")
	GameState.place_manager = self

func go_to(place : String):
	GameState.location = place
	for c in get_children():
		remove_child(c)
		c.queue_free()
	add_child(scenes[place].instance())
