extends Node2D

signal spawned_enemy_died

@export var enemy_scenes: Array[PackedScene] = []

var spawn_markers: Array[Marker2D] = []

func _ready() -> void:
	# get_children tagastab massiivi kõigi laps-sõlmedega
	for child in get_children():
		if (child is not Marker2D):
			continue
		spawn_markers.append(child)

# loob suvalise vastase ja asetab ta suvalise markeri asukohta
# vastase surma korral (died signaal) levitab enda spawned_enemy_died signaali
func _on_timer_timeout() -> void:
	var marker: Marker2D = spawn_markers.pick_random()
	var enemy_scene: PackedScene = enemy_scenes.pick_random()
	var enemy: Entity = enemy_scene.instantiate()
	enemy.global_position = marker.global_position
	enemy.died.connect(spawned_enemy_died.emit)
	add_child(enemy)
