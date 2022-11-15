extends Control

func update_room():
	$smartphone.is_usable = GameState.smartphone_whas_not_used
	$book.is_usable = GameState.book_whas_not_used

func init_room():
	var place = GameState.place_manager.places[name]
	place.elements = {
		'door'       : 'goto:Hall1',
		'smartphone' : 'Dial12',
		'book'       : 'Dial13',
		'computer'   : 'Des31'
	}
	place.inter = 'Des00'
