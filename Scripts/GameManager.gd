extends Node

var number_of_broken_servers := 0 setget set_broken_servers

onready var player : KinematicBody2D

######################### CUSTOM METHODS #########################

func set_broken_servers(value : int) -> void:
	number_of_broken_servers = value
	if number_of_broken_servers <= 0:
		$GUI/SystemFailureBar.value = 0

######################### BUILT-INS #########################

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		get_tree().paused = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		$GUI/PauseMenu.visible = true
		


func _process(delta: float) -> void:
	$GUI/SystemFailureBar.value += number_of_broken_servers * delta
	
######################### SIGNALS #########################

func _on_Server_state_changed(new_state : int) -> void:
	self.number_of_broken_servers += 2 * new_state - 1
	print(number_of_broken_servers)


func _on_SystemFailureBar_value_changed(value: float) -> void:
	if value == $GUI/SystemFailureBar.max_value:
		SceneSwitcher.goto_scene("res://Scenes/MainMenu.tscn")
