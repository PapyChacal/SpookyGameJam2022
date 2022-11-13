tool
extends Area2D
class_name ElementSprite

export(Texture) var texture : Texture

func _ready():
	var sprite = Sprite.new()
	sprite.texture = texture
	add_child(sprite)

	var collision = CollisionShape2D.new()
	collision.shape = RectangleShape2D.new()
	collision.shape.extents = sprite.get_rect().size/2
	
	add_child(collision)
	print(name, ' ready')

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
			#GameState.place_manager.interact(name)
			print('Interact with ', name)
			Fmod.play_one_shot("event:/UI/Click", self)

func get_shinies():
	var shinies : Array = []
	var prefix : String = "shiny"
	for c in get_children():
		if c.name.substr(0, prefix.length()) == prefix:
			shinies.append(c)
	return shinies

func _on_mouse_entered():
	for s in get_shinies():
		s.visible = true
	print('Mouse entered')

func _on_mouse_exited():
	for s in get_shinies():
		s.visible = false
	print('Mouse exited')
