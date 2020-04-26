extends Control

var tutorial_index := 0

onready var number_of_tutorials := $HBoxContainer/TutorialContainer/TutorialContent.get_child_count()

######################### CUSTOM METHODS #########################

func update_tutorial_page() -> void:
	var all_pages = $HBoxContainer/TutorialContainer/TutorialContent.get_children()
	for p in all_pages:
		p.hide()
	all_pages[tutorial_index].show()
	

######################### BUILT-INS #########################

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

######################### SIGNALS #########################


func _on_StartButton_pressed() -> void:
	SceneSwitcher.goto_scene("res://Scenes/WorldSelect.tscn")


func _on_QuitButton_pressed() -> void:
	get_tree().quit()


func _on_LeftButton_pressed() -> void:
	tutorial_index = max(0, tutorial_index - 1)
	if tutorial_index == 0:
		$HBoxContainer/TutorialContainer/ButtonContainer/LeftButton.disabled = true
	$HBoxContainer/TutorialContainer/ButtonContainer/RightButton.disabled = false
	update_tutorial_page()
	


func _on_RightButton_pressed() -> void:
	tutorial_index = min(tutorial_index + 1, number_of_tutorials - 1)
	if tutorial_index == number_of_tutorials - 1:
		$HBoxContainer/TutorialContainer/ButtonContainer/RightButton.disabled = true
	$HBoxContainer/TutorialContainer/ButtonContainer/LeftButton.disabled = false
	update_tutorial_page()
