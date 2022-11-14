extends Sprite
class_name elementSprite

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT \
	   and not GameState.text_menu_is_used:
		if get_rect().has_point(to_local(event.position)):
			GameState.place_manager.interact(name)
			Fmod.play_one_shot("event:/UI/Click", self)

