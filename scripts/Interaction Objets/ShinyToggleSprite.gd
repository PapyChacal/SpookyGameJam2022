extends elementSprite
class_name ShinyToggleSprite

func _ready():
	self.visible = false
	pass

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		if get_rect().has_point(to_local(event.position)):
			self.visible = !self.visible
