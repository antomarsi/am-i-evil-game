extends Area2D

export(String, "key_1", "key_2", "key_3", "key_4", "key_5", "key_6") var button

onready var sprite = $Sprite

var is_collecting = false
var is_pressed = false

func _ready():
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed(button):
		is_pressed = true
		is_collecting = true
		sprite.frame = 1
	elif event.is_action_released(button):
		sprite.frame = 0
		is_pressed = false
		is_collecting = false
