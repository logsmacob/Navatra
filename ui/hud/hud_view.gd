extends Control

func show_result(result: HandResult) -> void:
	$Label.text = str(result.type)

	for index in result.scoring_indices:
		#highlight_die(index)
		pass
