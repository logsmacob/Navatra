extends Control

signal reward_selected(reward: RewardDefinition)

@onready var rewards_container: VBoxContainer = $VBoxContainer

func show_rewards(rewards: Array) -> void:
	for child in rewards_container.get_children():
		child.queue_free()

	for reward_data in rewards:
		var reward: RewardDefinition = reward_data
		if reward == null:
			continue

		var button := Button.new()
		button.text = "%s\n%s" % [reward.title, reward.description]
		button.custom_minimum_size = Vector2(0, 72)
		button.pressed.connect(_on_reward_pressed.bind(reward))
		rewards_container.add_child(button)

	visible = true

func _on_reward_pressed(reward: RewardDefinition) -> void:
	reward_selected.emit(reward)
