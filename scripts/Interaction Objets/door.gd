extends Sprite

var is_clicked : bool = false

func _ready():
	self.visible = false
	pass

func _input(event):
	if event is InputEventMouse:
		if get_rect().has_point(to_local(event.position)):
			self.visible = true
		elif !is_clicked:
			self.visible = false
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		if get_rect().has_point(to_local(event.position)):
			self.visible = true
			is_clicked = true
