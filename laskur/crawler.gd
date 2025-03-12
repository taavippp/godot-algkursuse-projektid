extends CharacterBody2D

@export var speed: int = 75
@export var sprite: AnimatedSprite2D

var direction: float = 1.0
var gravity: int = 25

func _process(delta: float) -> void:
	if (is_on_wall()):
		direction = direction * -1.0
	velocity.x = speed * direction
	velocity.y += gravity
	sprite.flip_h = direction < 0.0
	move_and_slide()
