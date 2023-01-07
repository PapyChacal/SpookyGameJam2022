extends Control
func update_room():
	$brother.visible = GameState.brother_is_in_his_room

func init_room():
	var place = GameState.place_manager.places[name]
	place.elements = {
		'brother'      : '',
		'magazine'     : 'Dial14',
		'trash_can'    : 'Des8',
		'football'     : '',
		'brother_door_go_out' : 'goto:Hall2',
	}
	place.inter = ''

func _process(_delta):
	GameState.brother_is_in_his_room = $brother.visible
	if GameState.stress >= 40.00 and GameState.not_already_stress_on_1\
	   and Input.is_action_pressed("ui_select"):
		GameState.not_already_stress_on_1 = not GameState.choices.set_description('Des10')
