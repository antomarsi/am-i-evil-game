extends "res://src/Notes/BaseNote.gd"

onready var beam = $Beam
var current_length_in_m = 0
var length_in_m
var hold_started = false
var hold_finished = false
var hold_canceled = false

func _on_ready():
	._on_ready()
	length_in_m = length/length_scale
	$Beam.set_point_position(1, Vector2(0, -length_in_m))

func _on_process(delta):
	._on_process(delta)
	if not is_collected:
		if is_colliding and picker:
			if picker.is_collecting:
				hold_started = true
			elif hold_started:
				hold_canceled = true
		if hold_started and not hold_canceled:
			current_length_in_m += speed*delta
			length_in_m -= speed * delta
			if length_in_m <= 0:
				collect()
			else:
				beam.set_point_position(1, Vector2(0, -length_in_m))
				translate(Vector2(0, -speed*delta))
				pass
