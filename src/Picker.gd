extends Area2D

class_name Picker

signal picker_collecting
signal picker_stopped

export(String, "key_1", "key_2", "key_3", "key_4", "key_5", "key_6") var button
onready var smoke_particles = $Smoke
onready var spark_particles = $Sparks
onready var sprite = $Sprite
var note = null

func _ready():
	sprite.frame_coords.y = ["key_1", "key_2", "key_3", "key_4", "key_5", "key_6"].find(button)
	smoke_particles.emitting = false
	spark_particles.emitting = false

func _input(event):
	if event.is_action_pressed(button):
		sprite.frame_coords.x = 1
		emit_signal("picker_collecting", self)
	elif event.is_action_released(button):
		sprite.frame_coords.x = 0
		emit_signal("picker_stopped", self)


func _on_Picker_area_entered(area):
	if area.is_in_group("note") and note == null:
		note = area

func _on_Picker_area_exited(area):
	if area == note:
		if area.is_in_group("long_note") and area.holding:
			note = area
		else:
			note = null

func _play_particle(one_shoot=true):
	spark_particles.one_shot = one_shoot
	smoke_particles.one_shot = one_shoot
	spark_particles.emitting = true
	smoke_particles.emitting = true
	
func _stop_particles():
	smoke_particles.emitting = false
	spark_particles.emitting = false
