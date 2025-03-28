class_name Entity extends CharacterBody2D

signal died

@export_range(0.0, 1000.0) var speed: float = 200.0
@export_range(1, 10) var max_health: int = 3

var gravity: float = 25.0
var direction: float = 1.0
var health: int

func _ready() -> void:
	health = max_health

func take_damage() -> void:
	health = health - 1
	if health <= 0:
		died.emit()
		queue_free()
		return
	modulate = Color.TRANSPARENT # muudame sõlme läbipaistvaks
	var tween := create_tween() # loob Tweeni
	tween.tween_property(
		self,
		"modulate", # muutuja, mida animeerime
		Color.WHITE, # animeeritava muutuja lõppväärtus
		0.5 # animatsioon võtab pool sekundit
	)
