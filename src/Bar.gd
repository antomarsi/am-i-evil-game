extends Node2D

signal bar_exited

var note_scn = preload("res://prefabs/Note.tscn")

var notes_data = [
	{
		"pos": 0,
		"len": 100
	},
	{
		"pos": 400,
		"len": 100
	},
	{
		"pos": 800,
		"len": 100
	},
	{
		"pos": 1200,
		"len": 100
	},
]

var note_scale = 8

func _ready():
	add_notes()

func add_notes():
	randomize()
	for note_data in notes_data:
		var note = note_scn.instance()
		note.line = (randi() % 6) + 1
		note.pos = -int(note_data.pos/note_scale)
		add_child(note)


func _on_VisibilityNotifier2D_screen_exited():
	emit_signal("bar_exited", self)
