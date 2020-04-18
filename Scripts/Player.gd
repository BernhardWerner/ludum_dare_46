extends KinematicBody2D
class_name Player

export var speed := 400.0
export var gravity := 1000.0
export var jump_strength := 530.0

var velocity := Vector2.ZERO

######################### CUSTOM METHODS #########################

func get_input() -> Vector2:
	return Vector2(
			Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
			Input.get_action_strength("move_up") - Input.get_action_strength("move_down")
	)

######################### BUILT-INS #########################

func _ready() -> void:
	yield(owner, "ready")
	owner.player = self

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		if is_on_floor():
			velocity.y -= jump_strength
#		elif is_on_wall():
#			velocity.y -= 0.5 * sqrt(2) * jump_strength
#			velocity.x -= 0.5 * sqrt(2) * jump_strength * get_input().x

	##### DEBUG CONTROLS
	if event is InputEventKey and event.pressed:
		match event.scancode:
			KEY_R:
				get_tree().reload_current_scene()


func _physics_process(delta: float) -> void:
	var new_velocity = get_input()
	new_velocity.x *= speed
	new_velocity.y = velocity.y + gravity * delta
	
	velocity = move_and_slide(new_velocity, Vector2.UP)
	
			


######################### SIGNALS #########################
