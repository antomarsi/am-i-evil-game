extends Area2D

signal picker_collecting
signal picker_stopped

export(String, "key_1", "key_2", "key_3", "key_4", "key_5", "key_6") var button

onready var sprite = $Sprite

var is_collecting = false
var is_pressed = false

func _ready():
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed(button):
		sprite.frame = 1
		emit_signal("picker_collecting", self)
	elif event.is_action_released(button):
		sprite.frame = 0
		emit_signal("picker_stopped", self)
