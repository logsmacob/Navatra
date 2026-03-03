extends Node
class_name DieInstance

signal rolled(face: FaceData)

var data: DieData
var current_face: FaceData


func make_basic_die(face_count: int) -> DieData:
	data = DieData.new()

	set_up_die(face_count)

	var face_value_array: Array[int] = []

	for i in range(face_count):
		face_value_array.append(i + 1)  # usually dice start at 1

	apply_face_value(face_value_array)

	return data


func set_up_die(face_count: int) -> DieData:
	data.faces = []  # safer than clear()

	for i in range(face_count):
		data.faces.append(FaceData.new())

	return data


func apply_face_value(new_face_values: Array[int]) -> void:
	if new_face_values.size() == data.faces.size():
		for i in range(new_face_values.size()):
			data.faces[i].face_value = new_face_values[i]
	else:
		push_error("Face count mismatch!")


func roll() -> FaceData:
	if data == null or data.faces.is_empty():
		push_error("DieData not configured!")
		return null
	
	current_face = data.faces.pick_random()
	rolled.emit(current_face)
	return current_face
