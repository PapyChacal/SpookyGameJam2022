extends Area2D
class_name SceneItem

func _ready():
	var sprite : Sprite = get_child(0)
	var collision = CollisionShape2D.new()
	collision.shape = RectangleShape2D.new()
	var extents : Vector2 = sprite.get_rect().size/2
	extents.x *= sprite.scale.x
	extents.y *= sprite.scale.y
	collision.shape.extents = extents
	
	for s in get_shinies():
		s.visible = false
	
	add_child(collision)
	print(name, ' ready')

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
#			GameState.add_item(self)
			GameState.picked_item = self
			Fmod.play_one_shot("event:/UI/Validate", self)

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

func _on_mouse_exited():
	for s in get_shinies():
		s.visible = false
