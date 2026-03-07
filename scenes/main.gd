extends Control

@onready var hand: Control = $MarginContainer/Hand
@onready var quota_label: Label = $VBoxContainer/Quota
@onready var current_hand_points_label: Label = $VBoxContainer/CurrentHandPoints
@onready var hand_type_label: Label = $VBoxContainer/HandType
@onready var hand_type_value_label: Label = $VBoxContainer/HandTypeValue
@onready var hands_left_leabel: Label = $VBoxContainer/HandaLeft
@onready var rolls_left_label: Label = $VBoxContainer/RollsLeft

var score_manager: ScoreManager

func _ready() -> void:
	score_manager = ScoreManager.new()
	add_child(score_manager)

	hand.played_hand_ready.connect(_on_played_hand_ready)
	GameState.round_started.connect(_on_round_started)
	GameState.round_completed.connect(_on_round_completed)
	GameState.run_failed.connect(_on_run_failed)
	GameState.round_state_changed.connect(_on_round_state_changed)
	
	

func _on_played_hand_ready(hand_data: DiceHand) -> void:
	score_manager.preview_hand(hand_data.to_array())

	if not score_manager.can_play_hand():
		GameState.consume_hand()
		await get_tree().create_timer(1).timeout
		hand._on_played_hand_finish()
		return

	score_manager.play_hand()
	var played_hand_name := _get_played_hand_name()
	var applied_score := score_manager.commit_played_hand()
	print("Played hand: %s | points=%d" % [played_hand_name, applied_score])
	GameState.apply_score_to_quota(applied_score)
	GameState.consume_hand()

	await get_tree().create_timer(1).timeout
	hand._on_played_hand_finish()

func _get_played_hand_name() -> String:
	var breakdown := score_manager.get_last_breakdown()
	return str(breakdown.get("hand_name", "Unknown"))

func _on_round_started(round_index: int, quota: int, hands: int, rerolls: int) -> void:
	print("Round %d started | quota=%d hands=%d rerolls=%d" % [round_index, quota, hands, rerolls])

func _on_round_completed(round_index: int) -> void:
	print("Round %d complete" % round_index)
	GameState.start_next_round()

func _on_run_failed(round_index: int) -> void:
	print("Run failed on round %d" % round_index)

func _on_round_state_changed(state: Dictionary) -> void:
	print("State: ", state)

func ui_update():
	#update  all the label vars
	pass
