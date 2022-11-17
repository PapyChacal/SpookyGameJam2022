extends Area2D
class_name ElementSpritePersone

export(bool) var is_usable = true
export(bool) var has_limited_trys = true
export(int) var number_of_try = 1
var current_try = 0
export(bool) var must_disapear = false
var sprite : Sprite

func _ready():
	sprite  = get_child(0)
	var collision = CollisionShape2D.new()
	collision.shape = RectangleShape2D.new()
	var extents : Vector2 = sprite.get_rect().size/2
	extents.x *= sprite.scale.x
	extents.y *= sprite.scale.y
	collision.shape.extents = extents
	GameState._unused_connect_warning = connect('mouse_entered', self, '_on_mouse_entered')
	GameState._unused_connect_warning = connect('mouse_exited', self, '_on_mouse_exited')
	for s in get_shinies():
		s.visible = false
	
	add_child(collision)
	print(name, ' ready')

	if must_disapear and not is_usable:
		sprite.visible = false
		for s in get_shinies():
			s.visible = false

func _input_event(_viewport, event, _shape_idx):
	if is_usable:
		var can_click = true
		if has_limited_trys:
			can_click = current_try < number_of_try
		if can_click and event is InputEventMouseButton\
		   and event.pressed and event.button_index == BUTTON_LEFT\
		   and not GameState.text_menu_is_used:
				GameState.place_manager.interact(name)
				Fmod.play_one_shot("event:/UI/Click", Skipp_Fmod_Errors)
				if GameState.energy > 0:
					current_try+=1
	else:
		for s in get_shinies():
			s.visible = false
		if must_disapear:
			sprite.visible = false

func _process(_delta):
	if must_disapear and (current_try == number_of_try or not has_limited_trys):
		sprite.visible = false
		for s in get_shinies():
			s.visible = false

func get_shinies():
	var shinies : Array = []
	var prefix : String = "shiny"
	for c in get_children():
		if c.name.substr(0, prefix.length()) == prefix:
			shinies.append(c)
	return shinies

func _on_mouse_entered():
	if is_usable:
		var can_click = true
		if has_limited_trys:
			can_click = current_try < number_of_try
		if can_click:
			Fmod.play_one_shot_attached("event:/UI/Over", Skipp_Fmod_Errors)
			for s in get_shinies():
				s.visible = true
		else:
			for s in get_shinies():
				s.visible = false
	else:
		for s in get_shinies():
			s.visible = false

func _on_mouse_exited():
	if is_usable:
		for s in get_shinies():
			s.visible = false
	

