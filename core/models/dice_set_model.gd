class_name DiceSetModel

var dice: Array[DieModel] = []

func add_die(die: DieModel) -> void:
	dice.append(die)

func get_values() -> Array[int]:
	var values: Array[int] = []
	for die in dice:
		values.append(die.get_value())
	return values
