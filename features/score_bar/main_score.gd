extends PanelContainer
class_name MainScore

@onready var _quota_label: Label = get_node("center/Quota Value") as Label
@onready var _hand_type_label: Label = get_node("center/VBoxContainer/HandType") as Label
@onready var _base_label: Label = get_node("center/HBoxContainer/Base/HandTypeBase") as Label
@onready var _mult_label: Label = get_node("center/HBoxContainer/Mult/HandTypeMult") as Label
@onready var _result_label: Label = get_node("center/HBoxContainer/Total/HandTypeValue") as Label

func set_quota(value: int) -> void:
	_quota_label.text = str(value)

func set_hand_type(value: String) -> void:
	_hand_type_label.text = value

func set_base(value: int) -> void:
	_base_label.text = str(value)

func set_mult(value: int) -> void:
	_mult_label.text = str(value)

func set_result(value: int) -> void:
	_result_label.text = str(value)

func reset_math_display() -> void:
	set_hand_type("Hand Type:")
	zero_math_display()

func zero_math_display() -> void:
	set_base(0)
	set_mult(0)
	set_result(0)
