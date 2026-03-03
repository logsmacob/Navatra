extends Control

var dieui : DieUI

func _ready() -> void:
	dieui = $Die
	dieui.die = DieInstance.new()
	
	dieui.die.make_basic_die(6)

func _on_button_pressed() -> void:
	dieui.roll()
