class_name DieModel

signal value_changed(new_value: int)

var faces: Array[int]
var current_index: int = -1

func _init(face_values: Array[int]) -> void:
	faces = face_values.duplicate()

func roll_to(index: int) -> void:
	if index < 0 or index >= faces.size():
		return
	current_index = index
	value_changed.emit(get_value())

func get_value() -> int:
	if current_index == -1:
		return 0
	return faces[current_index]

func get_face_count() -> int:
	return faces.size()
