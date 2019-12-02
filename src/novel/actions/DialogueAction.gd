extends NovelAction

class_name DialogueAction

export (String, FILE, "*.json") var dialog_file_path : String

func interact() -> void:
	var dialogue : Dictionary = load_dialogye(dialog_file_path)
	yield(chapter.play_dialogue(dialogue), "completed")
	emit_signal("finished")

func load_dialogye(file_path) -> Dictionary:
	var file = File.new()
	assert(file.file_exists(file_path))
	
	file.open(file_path, file.READ)
	var dialogue = parse_json(file.get_as_text())
	assert(dialogue.size() > 0)
	return dialogue
