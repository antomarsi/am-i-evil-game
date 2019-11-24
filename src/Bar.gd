extends Node2D

signal bar_exited

var note_scn = preload("res://prefabs/Note.tscn")
var bar_data

var note_scale = 8

func _ready():
	add_notes()

func add_notes():
	var line = 1
	for line_data in bar_data:
		for note_data in line_data.notes:
			var note = note_scn.instance()
			note.line = line
			note.pos = -int(note_data.pos/note_scale)
			add_child(note)
		line += 1


func _on_VisibilityNotifier2D_screen_exited():
	emit_signal("bar_exited", self)
