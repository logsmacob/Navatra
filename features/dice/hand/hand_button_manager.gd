extends Node

class_name HandButtonManager

@export var play_hand: TextureButton
@export var re_roll: TextureButton

func _ready() -> void:
	play_hand.mouse_entered.connect(_on_hover)

func _on_hover():
	play_hand.scale = Vector2(1.1,1.1)

func disable_buttons():
	play_hand.disabled = true
	re_roll.disabled = true
	play_hand.modulate = Color(1, 1, 1, 0.5)
	re_roll.modulate = Color(1, 1, 1, 0.5)

func enable_buttons():
	play_hand.disabled = false
	re_roll.disabled = false
	play_hand.modulate = Color.WHITE
	re_roll.modulate = Color.WHITE

func update_button_labels():
	play_hand.get_child(0).text = "Play Hand\nx%d" % int(GameState.get_round_state().get("hands_remaining", 0))
	re_roll.get_child(0).text = "Re-Roll\nx%d" % int(GameState.get_round_state().get("rerolls_remaining", 0))
