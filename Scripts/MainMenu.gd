extends Control

######################### CUSTOM METHODS #########################



######################### BUILT-INS #########################

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

######################### SIGNALS #########################


func _on_StartButton_pressed() -> void:
	SceneSwitcher.goto_scene("res://Scenes/LevelTemplate.tscn")


func _on_QuitButton_pressed() -> void:
	get_tree().quit()
