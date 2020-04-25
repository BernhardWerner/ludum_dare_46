extends Node

export var time_to_sunrise := 120.0 
export var world_number := 0

var number_of_broken_servers := 0 setget set_broken_servers

onready var player : KinematicBody2D

signal level_complete(world_number)

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
	
	connect("level_complete", GlobalVariables, "_on_level_complete")
	
	# Spawn servers
	var spawn_points := $ServerSpawns.get_children().slice(0, GlobalVariables.server_numbers[world_number - 1] - 1)
	var server_scene := preload("res://Scenes/Server.tscn")
	for sp in spawn_points:
		sp = sp as ServerSpawn
		var new_server : Server = server_scene.instance()
		new_server.time_to_break           = sp.time_to_break
		new_server.time_to_break_variation = sp.time_to_break_variation
		new_server.global_position         = sp.global_position
		$Servers.add_child(new_server)
	$ServerSpawns.queue_free()
		
		


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		get_tree().paused = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		$GUI/PauseMenu.show()
		


func _process(delta: float) -> void:
	$GUI/SystemFailureBar.value += number_of_broken_servers * delta
	$GUI/SystemFailureLabel.text = round(100 - 100 * $GUI/SystemFailureBar.value / $GUI/SystemFailureBar.max_value) as String
	
	$Sky.material.set_shader_param("time_passed", 1 - $SunriseTimer.time_left / time_to_sunrise)
	
######################### SIGNALS #########################

func _on_Server_state_changed(new_state : int) -> void:
	self.number_of_broken_servers += 2 * new_state - 1


func _on_SystemFailureBar_value_changed(value: float) -> void:
	if value == $GUI/SystemFailureBar.max_value:
		get_tree().paused = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		$GUI/GameOver.show()


func _on_SunriseTimer_timeout():
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	emit_signal("level_complete", world_number)
	$GUI/WinScreen.show()
	


func _on_RestartButton_pressed() -> void:
	get_tree().paused = false
	SceneSwitcher.goto_scene(self.filename)


func _on_QuitButton_pressed() -> void:
	get_tree().paused = false
	SceneSwitcher.goto_scene("res://Scenes/MainMenu.tscn")


func _on_ResumeButton_pressed() -> void:
	$GUI/PauseMenu.visible = false
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
