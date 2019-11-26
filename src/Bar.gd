extends Node2D

signal bar_exited

var short_note_scn = preload("res://prefabs/ShortNote.tscn")
var long_note_scn = preload("res://prefabs/LongNote.tscn")
var bar_data
var speed
var pos_mod = 40
var note_scale = 8

func add_notes(keys:Picker[]):
	var line = 1
	for line_data in bar_data:
		var note_datas = line_data.notes
		for note_data in note_datas:
			var note = add_note(line, note_data)
			keys[line].connect("picker_collecting", note, "_on_Picker_pressed")
			keys[line].connect("picker_stopped", note, "_on_Picker_stopped")
			add_child(note)
		line += 1

func create_note(line, data):
	var note
	if int(data.len) > 100:
		note = long_note_scn.instance()
		note.set_line(int(data.len), note_scale, speed):
	else:
		note = short_note_scn.instance()
	note.set_pos(line, int(data.pos), pos_mod, note_scale)
	return note

func _on_VisibilityNotifier2D_screen_exited():
	emit_signal("bar_exited", self)
