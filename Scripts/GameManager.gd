extends Node

export var time_to_sunrise := 120.0 

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
	
	$SunriseTimer.wait_time = time_to_sunrise
	$SunriseTimer.start()
	
	


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		get_tree().paused = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		$GUI/PauseMenu.show()
		


func _process(delta: float) -> void:
	$GUI/SystemFailureBar.value += number_of_broken_servers * delta
	
	$Sky.material.set_shader_param("time_passed", 1 - $SunriseTimer.time_left / time_to_sunrise)
	
######################### SIGNALS #########################

func _on_Server_state_changed(new_state : int) -> void:
	self.number_of_broken_servers += 2 * new_state - 1


func _on_SystemFailureBar_value_changed(value: float) -> void:
	if value == $GUI/SystemFailureBar.max_value:
		SceneSwitcher.goto_scene("res://Scenes/MainMenu.tscn")


func _on_SunriseTimer_timeout():
	SceneSwitcher.goto_scene("res://Scenes/MainMenu.tscn")
