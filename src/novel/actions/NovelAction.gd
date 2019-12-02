extends Node

class_name NovelAction

signal finished

var chapter

func _ready() -> void:
	# using a group so LocalMap can initialize all Novel_Action
	add_to_group("novel_action")

func initialize(_chapter) -> void:
	chapter = _chapter

func interact() -> void:
	print("You forgot to override the interact method in " + name)
	emit_signal("finished")
