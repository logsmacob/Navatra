extends Node

var model: DieModel

func bind(die_model: DieModel) -> void:
	model = die_model

func _ready():
	$Button.pressed.connect(_on_pressed)

func _on_pressed():
	DiceRollService.roll_die(model)
