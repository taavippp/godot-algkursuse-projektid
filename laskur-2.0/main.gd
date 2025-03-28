extends Node2D

const PLAYER_BULLET_SCENE: PackedScene = preload("res://projectiles/bullet/bullet.tscn")
const HIGH_SCORE_FILE_PATH: String = "user://high_score.dat"

@export var score_label: Label
@export var death_background: ColorRect
@export var death_label: Label

var score: int = 0
var high_score: int = 0
var is_player_dead: bool = false

# loe faili et high_score saada
func _ready() -> void:
	death_background.hide()
	var file = FileAccess.open(HIGH_SCORE_FILE_PATH, FileAccess.READ)
	if is_instance_valid(file):
		high_score = int(file.get_as_text())
		print("Rekord on ", high_score)
	score_label.text = "Score: {cs}\nHigh score: {hs}".format({
		"cs": score,
		"hs": high_score
	})

func _on_player_shot_projectile(spawn_position: Vector2, direction: float) -> void:
	var bullet = PLAYER_BULLET_SCENE.instantiate()
	# tavaline position on oma vanem-stseeniga seotud
	bullet.global_position = spawn_position
	bullet.direction = direction
	# lisab praeguse stseeni laps-sõlmena selle
	add_child(bullet)

func _on_enemy_manager_spawned_enemy_died() -> void:
	score += 1
	score_label.text = "Score: {cs}\nHigh score: {hs}".format({
		"cs": score,
		"hs": high_score
	})

# kirjutame skoori faili, kui high_score ületatud
func _on_player_died() -> void:
	is_player_dead = true
	death_background.show()
	death_label.text = "Press any key to restart"
	if score <= high_score:
		return
	death_label.text += "\nYou got a new high score!" # sümbol \n alustab uue rea
	var file = FileAccess.open(HIGH_SCORE_FILE_PATH, FileAccess.WRITE)
	if is_instance_valid(file): # kontrollib, et fail eksisteerib
		file.store_string(String.num(score)) # muudab skoori ümber stringiks ja kirjutab faili

func _input(event: InputEvent) -> void:
	if (is_player_dead and # kas mängija on surnud
		event is InputEventKey and # InputEventKey on klaviatuuri sisendite klass
		event.is_pressed() and # kas klahvile vajutatakse
		not event.is_echo()): # kas klahvile hakati just vajutama
			get_tree().reload_current_scene() # käivitab praeguse stseeni uuesti
