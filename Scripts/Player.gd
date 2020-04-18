extends KinematicBody2D
class_name Player

export var speed := 400.0
export var gravity := 1500.0
export var jump_strength := 650.0

export var wall_push_multiplier := 3

export var acceleration := 0.25
export var friction := 0.5

export var wall_perception = 20.0

var move_dir := Vector2.ZERO
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
		elif $FrontWallRay.is_colliding():
			if move_dir.x == sign($FrontWallRay.cast_to.x):
				velocity.y = - 0.5 * sqrt(2) * jump_strength
				velocity.x = - 0.5 * sqrt(2) * jump_strength * move_dir.x
			else: 
				$WallJumpBuffer.start()

	##### DEBUG CONTROLS
	if event is InputEventKey and event.pressed:
		match event.scancode:
			KEY_R:
				get_tree().reload_current_scene()


func _physics_process(delta: float) -> void:
	move_dir = get_input()
	
	if move_dir.x == 0:
		velocity.x = lerp(velocity.x, 0, friction)
	else:
		velocity.x = lerp(velocity.x, move_dir.x * speed, acceleration)
		$Sprite.flip_h = (-0.5 * move_dir.x + 0.5) as bool
		$FrontWallRay.cast_to.x = wall_perception * move_dir.x
		$BackWallRay.cast_to.x = - 1.5 * wall_perception * move_dir.x
		
	# Wall slide
	var effective_gravity := gravity * delta * (10 if move_dir.y == -1 else 1)
	if velocity.y > 0 and ($FrontWallRay.is_colliding() or $BackWallRay.is_colliding()) and move_dir.x != 0:
		effective_gravity *= 0.25
	velocity.y += effective_gravity
	
	if $BackWallRay.is_colliding():
		if move_dir.x == sign($FrontWallRay.cast_to.x) and Input.is_action_just_pressed("jump") or not $WallJumpBuffer.is_stopped():
			velocity.y = - 1.0 * jump_strength
			velocity.x = wall_push_multiplier * jump_strength * move_dir.x
	
	velocity = move_and_slide(velocity, Vector2.UP)
	


######################### SIGNALS #########################
