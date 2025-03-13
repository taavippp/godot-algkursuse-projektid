class_name Hitbox extends Area2D

signal hit_entity

func _ready() -> void:
	body_entered.connect(_hitbox_body_entered)

func _hitbox_body_entered(body: Node2D):
	if (body is not Entity):
		return
	var entity := body as Entity
	entity.take_damage()
	hit_entity.emit()
