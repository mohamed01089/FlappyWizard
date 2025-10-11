extends Control

signal med
signal easy
signal hard

func _on_easy_pressed():
	easy.emit()
	get_tree().change_scene_to_file("res://main.tscn")

func _on_medium_pressed():
	med.emit()
	get_tree().change_scene_to_file("res://main.tscn")
	

func _on_hard_pressed():
	hard.emit()
	get_tree().change_scene_to_file("res://main.tscn")
	
