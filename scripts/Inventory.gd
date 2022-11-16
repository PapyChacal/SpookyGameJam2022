extends Control
class_name Inventory

func _ready():
	GameState.inventory = self

func _on_trigger():
#	print('Inventory trigger')
	$Zone.visible = true


func _on_untrigger():
#	print('Inventory trigger')
	$Zone.visible = false

func add_item(item : SceneItem):
#	print('Add ', item.name, ' to inventory.')
	item.get_parent().remove_child(item)
	var cont = CenterContainer.new()
	cont.add_child(item)
	item.position = Vector2.ZERO
	$Zone/BG/Container.add_child(cont)
