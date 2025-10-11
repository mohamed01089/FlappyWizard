extends CanvasLayer

signal restart


func _on_restart_pressed() -> void:
	restart.emit()


func _on_exit_pressed():
	get_tree().quit()
