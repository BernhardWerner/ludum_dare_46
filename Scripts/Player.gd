extends KinematicBody2D
class_name Player

export var speed := 400.0
export var gravity := 1000.0
export var jump_strength := 530.0

export var acceleration := 0.25
export var friction := 0.5

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
	var move_dir = get_input()
	
	if move_dir.x == 0:
		velocity.x = lerp(velocity.x, 0, friction)
	else:
		velocity.x = lerp(velocity.x, move_dir.x * speed, acceleration)
		$Sprite.flip_h = (-0.5 * move_dir.x + 0.5) as bool
		
	velocity.y += gravity * delta * (10 if move_dir.y == -1 else 1)
	
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	print($WallRay.is_colliding())
			


######################### SIGNALS #########################
