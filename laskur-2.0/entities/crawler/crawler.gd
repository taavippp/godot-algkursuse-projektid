extends Entity

@export var sprite: AnimatedSprite2D

func _process(delta: float) -> void:
	if is_on_wall():
		direction = direction * -1.0
	velocity.x = speed * direction
	velocity.y += gravity
	sprite.flip_h = direction < 0.0
	move_and_slide()
