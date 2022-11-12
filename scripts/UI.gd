extends Control
class_name UI

export(ImageTexture) var energy_icon = ImageTexture.new()

onready var energy = $UIContainer/EnergyContainer
onready var gauge = $UIContainer/StressGauge

func _ready():
	update_stress(50)
	update_energy(3)
	

func update_energy(n : int):
	for c in energy.get_children():
		energy.remove_child(c)
		c.queue_free()
	energy_icon.load('res://assets/energy.png')
	for _i in range(n):
		var icon = TextureRect.new()
		icon.expand = true
		icon.rect_min_size = Vector2(48, 48)
		icon.texture = energy_icon
		energy.add_child(icon)

func update_stress(s : float):
	gauge.value = s

func _process(delta):
	update_stress(GameState.stress)
	update_energy(GameState.energy)
