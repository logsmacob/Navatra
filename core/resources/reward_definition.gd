class_name RewardDefinition
extends Resource

enum RewardType {
	ADD_HAND,
	ADD_REROLL,
	ADD_SCORE,
	SCORE_MULT,
}

@export var id: String = ""
@export var title: String = ""
@export_multiline var description: String = ""
@export var type: RewardType = RewardType.ADD_HAND
@export var value: float = 0.0
