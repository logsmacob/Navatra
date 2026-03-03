extends Control
class_name DieUI

signal die_rolled

@onready var _face_label: Label = $Panel/FaceLabel
@onready var _select_button: Button = $Panel/SelectButton

var die: DieInstance

var is_selected : bool = false

func _ready():
	_select_button.pressed.connect(_on_select_pressed)

func _on_select_pressed():
	is_selected = !is_selected

func roll():
	if !is_selected:
		var roll_face : FaceData
		roll_face = die.roll()
		die_rolled.emit()
		
		_face_label.text = str(roll_face.face_value)
