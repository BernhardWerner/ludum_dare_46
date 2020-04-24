extends Area2D
class_name Server

enum STATES {RUNNING, BROKEN}

export var running_color := Color.blue
export var broken_color := Color.red
export(STATES) var state : int = STATES.RUNNING setget set_state

export(float) var time_to_break : float = 5.0
export(float) var time_to_break_variation : float = 1.0


var player_close := false


signal state_changed(new_state)

######################### CUSTOM METHODS #########################

func set_state(value : int) -> void:
	state = value
	emit_signal("state_changed", value)

######################### BUILT-INS #########################

func _ready() -> void:
	# Set states
	self.state = STATES.RUNNING
	
	
		# Set pulse color
	var broken_color_blank = broken_color * 1.5
	broken_color_blank.a = 0
	$Pulse.process_material.color_ramp.gradient.set_color(0, broken_color * 1.5)
	$Pulse.process_material.color_ramp.gradient.set_color(1, broken_color * 1.5)
	$Pulse.process_material.color_ramp.gradient.set_color(2, broken_color_blank)
	
	# Set health color
	$Health.tint_under = broken_color
	$Health.tint_progress = running_color
	
	# Set timer time
	randomize()
	$BreakTimer.wait_time = time_to_break + rand_range(-time_to_break_variation, time_to_break_variation)


	
	# Connect to Game Manager
	connect("state_changed", get_parent().get_parent(), "_on_Server_state_changed")



func _input(event: InputEvent) -> void:
	if player_close and state == STATES.BROKEN:
		if event.is_action_pressed("fix_server"):
			self.state = STATES.RUNNING


func _process(delta: float) -> void:
	$Health.value = $BreakTimer.time_left


######################### SIGNALS #########################


func _on_Server_state_changed(new_state : int) -> void:
	match new_state:
		STATES.RUNNING:
			$BackSprite/Lights.self_modulate = running_color * 1.3
			$Pulse.visible = false
			$Health.max_value = $BreakTimer.wait_time
			$BreakTimer.start()
			$SoundTimer.stop()
		STATES.BROKEN:
			$BackSprite/Lights.self_modulate = broken_color * 1.5
			$Pulse.visible = true
			$WarningSound.play()
			$SoundTimer.start()


func _on_Server_body_entered(body: Node) -> void:
	player_close = body is Player
	$Health.visible = true


func _on_Server_body_exited(body: Node) -> void:
	player_close = not body is Player
	$Health.visible = false


func _on_BreakTimer_timeout() -> void:
	self.state = STATES.BROKEN


func _on_SoundTimer_timeout() -> void:
	$WarningSound.play()
