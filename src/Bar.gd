extends Node2D

signal bar_exited

var short_note_scn = preload("res://prefabs/Note.tscn")
var long_note_scn = preload("res://prefabs/LongNote.tscn")
var speed
var pos_mod
var note_scale = 8

func set_bar_size(width, height):
	$Line2D.set_point_position(0, Vector2(-width, 0))
	$Line2D.set_point_position(1, Vector2(width, 0))
	$VisibilityNotifier2D.rect = Rect2(Vector2(-width, -height), Vector2(width, height))

func add_notes(bar_data, keys:Array, game:GameMusicManager):
	var line = 1
	for line_data in bar_data:
		var note_datas = line_data.notes
		for note_data in note_datas:
			var note = create_note(line, note_data, keys)
			note.connect("note_collected", game, "_on_Road_note_hitted")
			note.connect("note_missed", game, "_on_Road_note_missed")
			add_child(note)
		line += 1

func create_note(line:int, data, keys):
	var key = keys[line-1]
	var note
	if int(data.len) > 100:
		note = long_note_scn.instance()
		note.set_line(int(data.len), note_scale, speed)
		note.connect("note_holding", key, "_play_particle", [false])
		note.connect("note_collected", key, "_stop_particles")
		note.connect("note_stopped_holding", key, "_stop_particles")
	else:
		note = short_note_scn.instance()
		note.connect("note_collected", key, "_play_particle")
	key.connect("picker_collecting", note, "_on_Picker_pressed")
	key.connect("picker_stopped", note, "_on_Picker_stopped")
	note.set_pos(line, int(data.pos), pos_mod, note_scale)
	return note

func _on_VisibilityNotifier2D_screen_exited():
	emit_signal("bar_exited", self)
