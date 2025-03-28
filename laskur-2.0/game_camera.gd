extends Camera2D

@export var target: Node2D

func _process(delta: float) -> void:
	if not is_instance_valid(target):
		return
	global_position = target.global_position
