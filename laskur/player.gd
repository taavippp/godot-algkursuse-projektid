extends CharacterBody2D

signal shot_projectile(
	spawn_position: Vector2,
	direction: float
)

@export_range(0.0, 500.0) var speed: float = 200.0
@export_range(0, 1000.0) var jump_strength: float = 400.0

@export var bullet_marker: Marker2D
@export var sprite: AnimatedSprite2D

var gravity: float = 25.0
var direction_input: float = 0.0
var direction: float = 1.0

func _process(delta: float) -> void:
	direction_input = Input.get_axis("move_left", "move_right")
	# kui toimub liikumine, võib tegelik suund muutuda
	if not is_zero_approx(direction_input):
		direction = sign(direction_input)
	
	velocity.x = direction_input * speed
	velocity.y += gravity
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = -jump_strength
	
	# sätib markeri asendi õigeks olenevalt suunast
	bullet_marker.position.x = abs(bullet_marker.position.x) * direction
	if Input.is_action_just_pressed("shoot"):
		# annab põhistseenile teada, kuhu ja mis suunda kuul tekitada
		# kasutame global_position, sest position on suhteline juursõlmega
		shot_projectile.emit(
			bullet_marker.global_position,
			direction
		)
	
	_animate_sprite()
	
	move_and_slide()

func _animate_sprite():
	# pöörab spraiti, kui suund on vasakule
	sprite.flip_h = (direction < 0.0)
	
	# kui tegelane on maas ja ei liigu, siis "default" animatsioon
	# kui tegelane on maas ja liigub, siis "run" animatsioon
	# kui tegelane ei ole maas (ehk õhus), siis "jump" animatsioon
	if is_on_floor():
		if is_zero_approx(direction_input):
			sprite.play("default")
		else:
			sprite.play("run")
	else:
		sprite.play("jump")
