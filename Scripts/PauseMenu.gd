extends Popup

######################### CUSTOM METHODS #########################



######################### BUILT-INS #########################

func _ready() -> void:
	pass


######################### SIGNALS #########################


func _on_ResumeButton_pressed() -> void:
	self.visible = false
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _on_QuitButton_pressed() -> void:
	get_tree().paused = false
	SceneSwitcher.goto_scene("res://Scenes/MainMenu.tscn")
