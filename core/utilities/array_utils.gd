class_name ArrayUtils

static func max_index(values: Array[int]) -> int:
	var max_val = values[0]
	var index = 0
	for i in values.size():
		if values[i] > max_val:
			max_val = values[i]
			index = i
	return index
