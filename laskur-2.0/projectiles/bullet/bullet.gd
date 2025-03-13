extends CharacterBody2D

@export_range(0.0, 1000.0) var speed: int = 500.0
@export var sprite: Sprite2D

var direction: float = 1.0

func _ready() -> void:
	sprite.flip_h = direction < 0.0

func _process(delta: float) -> void:
	velocity.x = speed * direction
	if (is_on_wall()):
		queue_free() # kustutab sõlme
	move_and_slide()


func _on_hitbox_hit_entity() -> void:
	queue_free()
