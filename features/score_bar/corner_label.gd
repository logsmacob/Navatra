extends PanelContainer
class_name CornerLabel

@onready var _round_index_label: Label = get_node("left column/RoundIndex") as Label
@onready var _marble_label: Label = get_node("left column/Marbles") as Label

func set_round(round_index: int, max_rounds: int) -> void:
	_round_index_label.text = "Round %d/%d" % [round_index, max_rounds]

func set_marbles(amount: int) -> void:
	_marble_label.text = "Marbles: %d" % amount
