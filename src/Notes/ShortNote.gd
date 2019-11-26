extends "res://src/Notes/BaseNote.gd"

func _on_process(delta):
	._on_process(delta)
	if not is_collected:
		if is_colliding and picker and picker.is_collecting:
			collect()
