extends Node

var rng := RandomNumberGenerator.new()
var public_seed: int = 0

func set_seed(new_seed: int) -> void:
	public_seed = new_seed
	rng.seed = new_seed


func randi_range(min_value: int, max_value: int) -> int:
	return rng.randi_range(min_value, max_value)
