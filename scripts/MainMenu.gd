extends Control


func _input(_event):
	if Input.is_action_pressed("ui_cancel"):
		Fmod.play_one_shot("event:/UI/Validate", Skipp_Fmod_Errors)
		Fmod.play_one_shot("event:/Environment/Transition_Step", Skipp_Fmod_Errors)
		Fmod.play_one_shot("event:/Environment/Ambiance", Skipp_Fmod_Errors)
		GameState._unused_connect_warning = get_tree().change_scene("res://scenes/Main.tscn")
