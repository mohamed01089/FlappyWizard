extends Panel



func _on_back_pressed():
	get_tree().change_scene_to_file("res://StartMenu.tscn")
	







func _on_check_button_toggled(toggled_on: bool) -> void:
	if not toggled_on:
			AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), false)
	else:
			AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true)
