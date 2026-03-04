extends Node

@export var panel : Panel
@export var animator : AnimationPlayer
@export var die : DieUI

signal anim_roll_finished(die : DieUI)

func _on_die_die_selected(die_ui: DieUI) -> void:
	if die_ui.is_selected:
		panel.modulate = Color.DIM_GRAY
	else:
		panel.modulate = Color.WHITE

func play_roll_animation():
	animator.play("roll")
	


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "roll":
		anim_roll_finished.emit(die)
