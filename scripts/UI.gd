extends Control
class_name UI

export(ImageTexture) var energy_icon = preload('res://assets/energy.png')

onready var energy = $UIContainer/EnergyContainer
onready var gauge = $UIContainer/StressGauge

var icon : TextureRect = TextureRect.new()

func _ready():
	update_stress(50)
	update_energy(3)
	icon.expand = true
	icon.rect_min_size = Vector2(48, 48)
	icon.texture = energy_icon
	for c in energy.get_children():
		energy.remove_child(c)
		c.queue_free()
	

func update_energy(n : int):
	var current = energy.get_child_count()
	if n > current:
		for _i in range(n - current):
			energy.add_child(icon.duplicate())
	elif n < current:
		for _i in range(current - n):
			energy.remove_child(energy.get_child(0))

func update_stress(s : float):
	gauge.value = s

func _process(_delta):
	update_stress(GameState.stress)
	update_energy(GameState.energy)
