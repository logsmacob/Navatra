extends RefCounted

class_name HandScoringContext

var hand_type_upgrades: Dictionary
var round_score_multiplier: float

func _init(initial_hand_type_upgrades: Dictionary = {}, initial_round_score_multiplier: float = 1.0) -> void:
	hand_type_upgrades = initial_hand_type_upgrades.duplicate(true)
	round_score_multiplier = initial_round_score_multiplier

func get_hand_type_upgrade(hand_type: int) -> Dictionary:
	if not hand_type_upgrades.has(hand_type):
		return {"base": 0, "mult": 0}
	return (hand_type_upgrades[hand_type] as Dictionary).duplicate(true)
