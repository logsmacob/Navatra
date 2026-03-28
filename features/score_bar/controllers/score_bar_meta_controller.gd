extends Node
class_name ScoreBarMetaController

@export var corner_label: CornerLabel
@export var main_score: MainScore
@export var info_screen: InfoScreen

func update_state(state: Dictionary, general_modifiers: Dictionary) -> void:
	if corner_label != null:
		corner_label.set_round(int(state.get("round_index", 0)), GameState.MAX_ROUNDS)
		corner_label.set_marbles(int(state.get("currency", 0)))
	if main_score != null:
		main_score.set_quota(int(state.get("quota_remaining", 0)))
	if info_screen != null:
		info_screen.update_general_modifiers(general_modifiers)
