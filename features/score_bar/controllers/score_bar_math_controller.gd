extends Node
class_name ScoreBarMathController

const CALCULATION_DELAY_SECONDS := 0.5

var _hand_type_label: Label
var _base_label: Label
var _mult_label: Label
var _result_label: Label

var _preview_breakdown: Dictionary = {}
var _show_preview_math: bool = false

func setup(
	hand_type_label: Label,
	base_label: Label,
	mult_label: Label,
	result_label: Label
) -> void:
	_hand_type_label = hand_type_label
	_base_label = base_label
	_mult_label = mult_label
	_result_label = result_label

func update_preview(breakdown: Dictionary) -> void:
	_preview_breakdown = breakdown.duplicate(true)
	if breakdown.is_empty():
		_hand_type_label.text = "Hand Type:"
		_zero_math_display()
		return

	var hand_name := str(breakdown.get("hand_name", "-"))
	var base_value := int(breakdown.get("base", 0))
	var group_total := int(breakdown.get("group_total", 0))
	var mult_value := int(breakdown.get("mult", 0))
	var final_score := int(breakdown.get("final_score", 0))
	_hand_type_label.text = "%s:" % hand_name
	if _show_preview_math:
		_apply_preview_math(base_value, group_total, mult_value, final_score)

func animate_played_hand(tree: SceneTree, breakdown: Dictionary) -> void:
	var hand_name := str(breakdown.get("hand_name", "-"))
	var base_value := int(breakdown.get("base", 0))
	var group_total := int(breakdown.get("group_total", 0))
	var mult_value := int(breakdown.get("mult", 0))
	var final_score := int(breakdown.get("final_score", 0))

	_show_preview_math = false
	_hand_type_label.text = "%s:" % hand_name
	_zero_math_display()
	await tree.create_timer(CALCULATION_DELAY_SECONDS).timeout

	_base_label.text = "%d" % base_value
	await tree.create_timer(CALCULATION_DELAY_SECONDS).timeout

	_mult_label.text = "%d" % mult_value
	await tree.create_timer(CALCULATION_DELAY_SECONDS).timeout

	_base_label.text = "%d" % (base_value + group_total)
	await tree.create_timer(CALCULATION_DELAY_SECONDS).timeout

	_result_label.text = "%d" % final_score

func reset_display() -> void:
	_preview_breakdown.clear()
	_show_preview_math = false
	_zero_math_display()
	_hand_type_label.text = "Hand Type:"

func zero_math_display() -> void:
	_show_preview_math = false
	_zero_math_display()

func clear_after_play_reset() -> void:
	_show_preview_math = false
	if _preview_breakdown.is_empty():
		return
	update_preview(_preview_breakdown)

func show_preview_math() -> void:
	_show_preview_math = true
	if _preview_breakdown.is_empty():
		return
	_apply_preview_math(
		int(_preview_breakdown.get("base", 0)),
		int(_preview_breakdown.get("group_total", 0)),
		int(_preview_breakdown.get("mult", 0)),
		int(_preview_breakdown.get("final_score", 0))
	)

func hide_preview_math() -> void:
	_show_preview_math = false
	_zero_math_display()

func _zero_math_display() -> void:
	_base_label.text = "%d" % 0
	_mult_label.text = "%d" % 0
	_result_label.text = "%d" % 0

func _apply_preview_math(base_value: int, group_total: int, mult_value: int, final_score: int) -> void:
	_base_label.text = "%d" % (base_value + group_total)
	_mult_label.text = "%d" % mult_value
	_result_label.text = "%d" % final_score
