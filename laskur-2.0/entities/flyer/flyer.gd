extends Entity

@export var sprite: AnimatedSprite2D

func _ready() -> void:
	super() # kutsub oma ülemklassi (ehk Entity) _ready() funktsiooni
	sprite.flip_h = (direction < 0.0)
	var tween = create_tween()
	# paneb Tweeni animatsiooni korduma
	# vajaduse korral saab ka korduste arvu kirjutada, aga tahame et ta jääkski korduma
	tween.set_loops()
	tween.tween_property(
		self,
		"velocity:y", # muudab velocity.y väärtust
		speed,
		1.0 # võtab 1 sekund
	)
	# toimub peale eelmise tween_property lõppu
	tween.tween_property(
		self,
		"velocity:y",
		-(speed),
		1.0
	)

func _process(delta: float) -> void:
	move_and_slide()
