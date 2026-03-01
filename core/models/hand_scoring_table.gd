class_name HandScoringTable

# NOTE: Foundation values that can later be moved to external resources.
# The keys are HandEvaluatorModel.HandType values.
const BASE_BY_TYPE := {
	HandEvaluatorModel.HandType.HIGH_DIE: 5,
	HandEvaluatorModel.HandType.ONE_PAIR: 5,
	HandEvaluatorModel.HandType.TWO_PAIR: 10,
	HandEvaluatorModel.HandType.THREE_OF_A_KIND: 15,
	HandEvaluatorModel.HandType.STRAIGHT: 20,
	HandEvaluatorModel.HandType.FULL_HOUSE: 25,
	HandEvaluatorModel.HandType.FOUR_OF_A_KIND: 25,
	HandEvaluatorModel.HandType.FIVE_OF_A_KIND: 30
}

const MULT_BY_TYPE := {
	HandEvaluatorModel.HandType.HIGH_DIE: 2,
	HandEvaluatorModel.HandType.ONE_PAIR: 2,
	HandEvaluatorModel.HandType.TWO_PAIR: 3,
	HandEvaluatorModel.HandType.THREE_OF_A_KIND: 4,
	HandEvaluatorModel.HandType.STRAIGHT: 6,
	HandEvaluatorModel.HandType.FULL_HOUSE: 8,
	HandEvaluatorModel.HandType.FOUR_OF_A_KIND: 10,
	HandEvaluatorModel.HandType.FIVE_OF_A_KIND: 14
}

static func get_base(hand_type: int) -> int:
	if not BASE_BY_TYPE.has(hand_type):
		return 0
	return BASE_BY_TYPE[hand_type]

static func get_mult(hand_type: int) -> float:
	if not MULT_BY_TYPE.has(hand_type):
		return 0.0
	return MULT_BY_TYPE[hand_type]
