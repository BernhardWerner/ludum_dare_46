extends Area2D

export var knockback := 3000.0

func _ready():
	pass


func _on_CooldownTimer_timeout():
	$AnimatedSprite.show()
	monitoring = true
	$FireTimer.start()


func _on_FireTimer_timeout():
	$AnimatedSprite.hide()
	monitoring = false
	$CooldownTimer.start()


func _on_LightningDoor_body_entered(body):
	if body is Player and $CooldownTimer.is_stopped():
		body.velocity.x += knockback * sign(body.global_position.x - self.global_position.x)
