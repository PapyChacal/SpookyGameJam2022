extends Node2D

var Fmod : FmodNative = FmodNative.new()
const placeholder = "event:/UI/Click"
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# load banks

# Called when the node enters the scene tree for the first time.
func _ready():
		# set up FMOD
	Fmod.set_software_format(0, Fmod.FMOD_SPEAKERMODE_STEREO, 0)
	Fmod.init(1024, Fmod.FMOD_STUDIO_INIT_NORMAL, Fmod.FMOD_INIT_NORMAL)
	
	Fmod.load_bank("res://Sounds/Desktop/Master.strings.bank", Fmod.FMOD_STUDIO_LOAD_BANK_NORMAL)
	Fmod.load_bank("res://Sounds/Desktop/Main.bank", Fmod.FMOD_STUDIO_LOAD_BANK_NORMAL)
	Fmod.load_bank("res://Sounds/Desktop/Master.bank", Fmod.FMOD_STUDIO_LOAD_BANK_NORMAL)
	
	Fmod.wait_for_all_loads()
	
	# register listener
	Fmod.add_listener(0, self)

	# play some events
	#Fmod.play_one_shot("event:/Musics/Placeholder", self)
#	var event = Fmod.create_event_instance(placeholder)
	Fmod.play_one_shot(placeholder, self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(Fmod.get_event_playback_state(placeholder))
	Fmod._process(delta)
	
	pass
