extends Control

func _on_trigger():
	print('Inventory trigger')
	$Zone.visible = true


func _on_untrigger():
	print('Inventory trigger')
	$Zone.visible = false
