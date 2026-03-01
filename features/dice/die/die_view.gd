extends Node2D

var model: DieModel

func bind(die_model: DieModel) -> void:
	model = die_model
	model.value_changed.connect(_on_value_changed)

func _on_value_changed(value: int) -> void:
	# Update sprite frame or label
	pass
