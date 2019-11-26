extends Node2D

signal bar_exited

var short_note_scn = preload("res://prefabs/ShortNote.tscn")
var long_note_scn = preload("res://prefabs/LongNote.tscn")
var bar_data
var speed
var pos_mod = 40
var note_scale = 8

func _ready():
	add_notes()

func add_notes():
	var line = 1
	for line_data in bar_data:
		var note_datas = line_data.notes
		for note_data in note_datas:
			add_note(line, note_data)
		line += 1

func add_note(line, data):
	var note : BaseNote
	if int(data.len) > 100:
		note = long_note_scn.instance()
	else:
		note = short_note_scn.instance()
	note.set_pos(line, int(data.pos), pos_mod, note_scale)
	note.speed = speed
	note.length = int(data.len)
	add_child(note)

func _on_VisibilityNotifier2D_screen_exited():
	emit_signal("bar_exited", self)
