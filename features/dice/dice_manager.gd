extends Node

var dice_set := DiceSetModel.new()

func _ready():
	# Create 5 dice
	for i in 5:
		var die = DieModel.new([1,2,3,4,5,6])
		dice_set.add_die(die)

func roll_all():
	DiceRollService.roll_all(dice_set)

func evaluate():
	var result = HandEvaluatorModel.evaluate(dice_set.get_values())
	return result
