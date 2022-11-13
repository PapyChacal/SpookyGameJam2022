extends Node

const interactions_file = 'res://assets/interactions.json'

const dialogue_type = preload("res://scripts/dialogue.gd")
const description_type = preload("res://scripts/description.gd")

var lines : Dictionary

func _ready():
	lines = load_interactions(interactions_file)

func load_interactions(path : String):
	var f : File = File.new()
# warning-ignore:return_value_discarded
	f.open(path, File.READ)
	
	var dict_save = JSON.parse(f.get_as_text()).result
#	print(dict_save)
	var dict = {}
	
	if dict_save == null:
		push_error("Interaction file not found. No story loaded. No fun here.")
	
	for id in dict_save:
		if dict_save[id].has('possible_reponses'):
			var reponses : Array = []
			for r in dict_save[id]['possible_reponses']:
				reponses.append(reponse.new(r.text, r.next))
				
			dict[id] = dialogue.new(
				dict_save[id].personne_parlant,
				dict_save[id].text,
				dict_save[id].energie_add,
				dict_save[id].stress_add,
				reponses
			)
		else:
			dict[id] = description.new(
				dict_save[id].personne_parlant,
				dict_save[id].text,
				dict_save[id].energie_add,
				dict_save[id].stress_add,
				dict_save[id].next
			)
	
	return dict

func save_interactions(dict : Dictionary, path : String):
	var f : File = File.new()
# warning-ignore:return_value_discarded
	f.open(path, File.WRITE)
	
	var dict_save = {}
	
	for id in dict:
		if dict[id] is dialogue_type:
			var reponses : Array = []
			for r in dict[id].possible_reponses:
				reponses.append({
					"text" : r.text,
					"next" : r.next,
				})
			dict_save[id] = {
				"personne_parlant" : dict[id].personne_parlant,
				"text" : dict[id].text,
				"stress_add": dict[id].stress_add,
				"energie_add": dict[id].energie_add,
				"possible_reponses": reponses,
			}
		
		elif dict[id] is GameState.description_type:
			dict_save[id] = {
				"personne_parlant" : dict[id].personne_parlant,
				"text" : dict[id].text,
				"stress_add": dict[id].stress_add,
				"energie_add": dict[id].energie_add,
				"next": dict[id].next
			}
	
	f.store_string(JSON.print(dict_save, "  "))
