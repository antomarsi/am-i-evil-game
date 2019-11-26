extends "res://src/Notes/BaseNote.gd"

onready var beam = $Beam
var current_length_in_m = 0
var length_in_m
var speed
var hold_started = false
var picker

func set_pos(line:int, pos_y:int, pos_mod:float, length_scale:float):
	.set_pos(line, pos_y, pos_mod, length_scale)

func set_line(length, length_scale, speed):
	length_in_m = length/length_scale
	speed = speed
	$Beam.set_point_position(1, Vector2(0, -length_in_m))

func _on_Picker_pressed(picker):
	if is_in_area:
		hold_started = true
		picker = picker
		collect()

func _on_Picker_stopped(picker):
	hold_started = false
	pass

func _on_Note_area_entered(area):
	if area.is_in_group("picker"):
		is_in_area = true

func _on_Note_area_exited(area):
	if area.is_in_group("picker") and !hold_started:
		emit_signal("note_missed", self)
		is_in_area = false
		set_physics_process(false)

func _process(delta):
		if is_in_area and hold_started:
			length_in_m -= speed * delta
			if length_in_m <= 0:
				collect()
			else:
				beam.set_point_position(0, Vector2(0, -length_in_m))
				translate(Vector2(0, -speed*delta))
