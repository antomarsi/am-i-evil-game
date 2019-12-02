extends "res://src/Notes/BaseNote.gd"

signal note_holding
signal note_stopped_holding

onready var beam = $Beam
var current_length_in_m = 0
var length_in_m
var speed
var holding = false
var picker

func set_pos(line:int, pos_y:int, pos_mod:float, length_scale:float):
	.set_pos(line, pos_y, pos_mod, length_scale)

func set_line(length, length_scale, _speed):
	length_in_m = length/length_scale
	speed = _speed
	$Beam.set_point_position(1, Vector2(0, -length_in_m))

func _on_Picker_pressed(picker):
	if is_in_area and picker.note == self:
		holding = true
		picker = picker
		emit_signal("note_holding")

func _on_Picker_stopped(picker):
	if picker.note == self:
		picker.note == null
		emit_signal("note_stopped_holding")

func _on_Note_area_entered(area):
	if area.is_in_group("picker"):
		is_in_area = true
		collected = true

func _on_Note_area_exited(area):
	if area.is_in_group("picker") and not holding:
		emit_signal("note_missed", self)
		is_in_area = false

func _process(delta):
		if is_in_area and holding:
			length_in_m -= speed * delta
			if length_in_m <= 0:
				collect()
				if picker:
					picker.note = null
			else:
				beam.set_point_position(1, Vector2(0, -length_in_m))
				translate(Vector2(0, -speed*delta))
