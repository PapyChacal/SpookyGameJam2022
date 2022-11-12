extends Sprite


func _ready():
	for n in get_children():
		n.visible = false
	pass

func _input(event):
	if event is InputEventMouse:
		if get_rect().has_point(to_local(event.position)):
			for n in get_children():
				n.visible = true
		else:
			for n in get_children():
				n.visible = false
