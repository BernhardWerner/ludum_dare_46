tool

extends Area2D

enum STATES {RUNNING, BROKEN}

export var running_color := Color.blue
export var broken_color := Color.red
export(STATES) var state : int = STATES.BROKEN setget set_state


var player_close := false



signal state_changed(new_state)

######################### CUSTOM METHODS #########################

func set_state(value : int) -> void:
	state = value
	emit_signal("state_changed", value)
	print(state)

######################### BUILT-INS #########################

func _ready() -> void:
	yield(owner, "ready")
	self.state = STATES.BROKEN
	
func _input(event: InputEvent) -> void:
	if player_close and state == STATES.BROKEN:
		if event.is_action_pressed("fix_server"):
			self.state = STATES.RUNNING
			
######################### SIGNALS #########################


func _on_Server_state_changed(new_state : int) -> void:
	match new_state:
		STATES.RUNNING:
			$BackSprite/Lights.self_modulate = running_color
		STATES.BROKEN:
			$BackSprite/Lights.self_modulate = broken_color


func _on_Server_body_entered(body: Node) -> void:
	player_close = body == GameManager.player
		


func _on_Server_body_exited(body: Node) -> void:
	player_close = not body == GameManager.player
