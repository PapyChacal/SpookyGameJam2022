extends Control

onready var scenes : Dictionary = {
	'Room'     : preload("res://scenes/Room.tscn"),
	'Hall1'    : preload("res://scenes/Hall1.tscn"),
	'Hall2'    : preload("res://scenes/Hall2.tscn"),
	'Kitchen1' : preload("res://scenes/Kitchen1.tscn"),
	'BrotherRoom' : preload("res://scenes/BrotherRoom.tscn"),
	'Death'       : preload("res://scenes/Death.tscn")
}

onready var places : Dictionary = {
	'Room' : place.new(),
	'Hall1': place.new(),
	'Hall2': place.new(),
	'Kitchen1': place.new(),
	'BrotherRoom': place.new(),
	'Death' : place.new()
}

signal trigger_action

func interact(name : String):
	# Démarrer interaction avec l'objet 'name'
#	print('PM: Interact with ', name)
	# Le nom de l'action à déclencher
	var action = places[GameState.location].elements[name]
#	print('action: ', action)
	emit_signal("trigger_action", action)

func _ready():
	GameState._unused_connect_warning = connect("trigger_action", GameState, "trigger_action")
	GameState.place_manager = self
	init()

func init():
	for p in scenes.values():
		var inst = p.instance()
		inst.init_room()
		inst.queue_free()

func go_to(place : String):
	GameState.location = place
	var inst = scenes[place].instance()
	inst.update_room()
	for c in get_children():
		remove_child(c)
		c.queue_free()
	add_child(inst)
	var interpelation = places[place].inter
	if GameState.current_dial_descr != '':
		interpelation = GameState.current_dial_descr
	
	GameState.trigger_action(interpelation)
