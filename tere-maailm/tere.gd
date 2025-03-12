extends Control

@export var label: Label
@export var text_edit: TextEdit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = "Tere Godot!"

func _on_button_pressed() -> void:
	label.text = "Tere " + text_edit.text
	text_edit.text = ""
