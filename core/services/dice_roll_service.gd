class_name DiceRollService

static func roll_die(die: DieModel) -> void:
	var max_index = die.get_face_count() - 1
	var index = RandomService.randi_range(0, max_index)
	die.roll_to(index)

static func roll_all(dice_set: DiceSetModel) -> void:
	for die in dice_set.dice:
		roll_die(die)
