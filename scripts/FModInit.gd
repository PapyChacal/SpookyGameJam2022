extends Node

# AutoLoad script
# It will be automatically created at lau

#Initialize FMod
func _ready():
		# set up FMOD
	Fmod.set_software_format(0, Fmod.FMOD_SPEAKERMODE_STEREO, 0)
	Fmod.init(1024, Fmod.FMOD_STUDIO_INIT_LIVEUPDATE, Fmod.FMOD_INIT_NORMAL)
	
	Fmod.load_bank("res://Sounds/Desktop/Master.strings.bank", Fmod.FMOD_STUDIO_LOAD_BANK_NORMAL)
	Fmod.load_bank("res://Sounds/Desktop/Main.bank", Fmod.FMOD_STUDIO_LOAD_BANK_NORMAL)
	Fmod.load_bank("res://Sounds/Desktop/Master.bank", Fmod.FMOD_STUDIO_LOAD_BANK_NORMAL)
	
	Fmod.add_listener(0,self)

# Tick FMod every, well, tick
func _process(delta):
	Fmod._process(delta)
