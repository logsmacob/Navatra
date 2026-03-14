extends Control

@export var shop: Button

func _ready() -> void:
	shop.pressed.connect(pressed)

func pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
