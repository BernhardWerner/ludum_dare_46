extends Control

######################### CUSTOM METHODS #########################

func go_to_main_menu() -> void:
	SceneSwitcher.goto_scene("res://Scenes/MainMenu.tscn")

######################### BUILT-INS #########################

func _ready():
	GlobalVariables.load_game()
