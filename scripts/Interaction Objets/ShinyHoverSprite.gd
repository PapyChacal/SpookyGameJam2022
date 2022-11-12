extends elementSprite
class_name ShinyHoverSprite

func _ready():
	self.visible = false

func _input(event):
	if event is InputEventMouse:
		if get_rect().has_point(to_local(event.position)):
			self.visible = true
		else:
			self.visible = false
