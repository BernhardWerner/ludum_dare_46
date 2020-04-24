extends Control


func _ready() -> void:
	var world_buttons := $VBoxContainer/HBoxContainer/WorldButtonContainer.get_children()
	var server_infos := $VBoxContainer/HBoxContainer/VBoxContainer.get_children() + $VBoxContainer/HBoxContainer/VBoxContainer2.get_children()
	for i in range(4):
		if GlobalVariables.worlds_unlocked[i]:
			world_buttons[i].disabled = false
			server_infos[i].get_children()[0].texture = preload("res://Graphics/server_00_running.png")
			server_infos[i].get_children()[1].text = GlobalVariables.server_numbers[i] as String


func _on_World1Button_pressed() -> void:
	SceneSwitcher.goto_scene("res://Scenes/ThePlain.tscn")


func _on_World2Button_pressed() -> void:
	SceneSwitcher.goto_scene("res://Scenes/ThePyramid.tscn")


func _on_World3Button_pressed() -> void:
	SceneSwitcher.goto_scene("res://Scenes/TheRavine.tscn")


func _on_World4Button_pressed() -> void:
	SceneSwitcher.goto_scene("res://Scenes/TheBolt.tscn")


func _on_BackButton_pressed() -> void:
	SceneSwitcher.goto_scene("res://Scenes/MainMenu.tscn")
