extends Control

func update_room():
	$toilet.is_usable = GameState.toilet_whas_not_used
	$brother.visible = not GameState.brother_is_not_here
	$brother_door_enter.is_usable = GameState.brother_is_not_here

func init_room():
	var place = GameState.place_manager.places[name]
	place.elements = {
		'brother'      : 'Dial6',
		'staircase'    : 'goto:Room',
		'toilet'       : 'Des5',
		'plant'        : 'Des4',
		'door_kitchen' : 'goto:Kitchen1',
		'brother_door_enter' : 'goto:BrotherRoom',
	}
	place.inter = ''

func _process(_delta):
	if GameState.energy == 3:
		$toilet.is_usable = false
	else:
		$toilet.is_usable = GameState.toilet_whas_not_used
