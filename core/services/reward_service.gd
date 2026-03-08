extends RefCounted
class_name RewardService

var _reward_pool: Array[RewardDefinition] = []

func _init() -> void:
	_build_default_reward_pool()

func generate_rewards(count: int) -> Array[RewardDefinition]:
	if _reward_pool.is_empty() or count <= 0:
		return []

	var available_rewards: Array[RewardDefinition] = _reward_pool.duplicate()
	available_rewards.shuffle()

	var picked_rewards: Array[RewardDefinition] = []
	var pick_count: int = mini(count, available_rewards.size())
	for i in range(pick_count):
		picked_rewards.append(available_rewards[i])

	return picked_rewards

func apply_reward(reward: RewardDefinition, game_state: Node) -> void:
	if reward == null or game_state == null:
		return

	match reward.type:
		RewardDefinition.RewardType.ADD_HAND:
			if game_state.has_method("add_next_round_hands_bonus"):
				game_state.call("add_next_round_hands_bonus", int(reward.value))
		RewardDefinition.RewardType.ADD_REROLL:
			if game_state.has_method("add_next_round_rerolls_bonus"):
				game_state.call("add_next_round_rerolls_bonus", int(reward.value))
		RewardDefinition.RewardType.ADD_SCORE:
			if game_state.has_method("add_next_round_quota_reduction"):
				game_state.call("add_next_round_quota_reduction", int(reward.value))
		RewardDefinition.RewardType.SCORE_MULT:
			if game_state.has_method("add_next_round_score_multiplier_bonus"):
				game_state.call("add_next_round_score_multiplier_bonus", reward.value)

func _build_default_reward_pool() -> void:
	_reward_pool.clear()
	_reward_pool.append(_create_reward(
		"add_hand",
		"Tactical Reserve",
		"+1 hand next round.",
		RewardDefinition.RewardType.ADD_HAND,
		1.0
	))
	_reward_pool.append(_create_reward(
		"add_reroll",
		"Lucky Shift",
		"+1 reroll next round.",
		RewardDefinition.RewardType.ADD_REROLL,
		1.0
	))
	_reward_pool.append(_create_reward(
		"add_score",
		"Quota Relief",
		"Reduce next round quota by 50.",
		RewardDefinition.RewardType.ADD_SCORE,
		50.0
	))
	_reward_pool.append(_create_reward(
		"score_mult",
		"Momentum",
		"+10% score multiplier next round.",
		RewardDefinition.RewardType.SCORE_MULT,
		0.1
	))

func _create_reward(reward_id: String, reward_title: String, reward_description: String, reward_type: RewardDefinition.RewardType, reward_value: float) -> RewardDefinition:
	var reward := RewardDefinition.new()
	reward.id = reward_id
	reward.title = reward_title
	reward.description = reward_description
	reward.type = reward_type
	reward.value = reward_value
	return reward
