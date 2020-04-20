extends Path2D

export var speed := 0.1

func _ready():
	pass # Replace with function body.

func _process(delta):
	$PathFollow2D.unit_offset = wrapf($PathFollow2D.unit_offset + speed * delta, 0, 1)
