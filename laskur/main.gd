extends Node2D

const PLAYER_BULLET_SCENE: PackedScene = preload("res://bullet.tscn")

func _on_player_shot_projectile(spawn_position: Vector2, direction: float) -> void:
	var bullet = PLAYER_BULLET_SCENE.instantiate()
	# tavaline position on oma vanem-stseeniga seotud
	bullet.global_position = spawn_position
	bullet.direction = direction
	# lisab selle stseeni laps-sõlmena selle
	add_child(bullet)
