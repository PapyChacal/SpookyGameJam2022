extends Node

var energy : int = 3
var stress : float = 50.0

#Dumb update of stress for now
func _process(delta):
	stress += 20 * delta
	while stress >= 100:
		stress -= 100
