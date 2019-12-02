extends Control

class_name DialogueBox

signal dialogue_ended

export(float) var TIME_DELAY = 0.01

onready var dialogue_player : DialoguePlayer = $DialoguePlayer
onready var name_label : = $NamePanel/Name as Label
onready var text_label : = $Panel/Text as RichTextLabel
onready var button_next : = $Panel/ButtonNext as Button
onready var portrait : = $Portrait as TextureRect
onready var timer : = $Timer as Timer

func _ready():
	timer.wait_time = TIME_DELAY
	hide()

func start(dialogue : Dictionary) -> void:
	button_next.show()
	button_next.grab_focus()
	dialogue_player.start(dialogue)
	update_content()
	show()

func _on_ButtonNext_pressed():
	dialogue_player.next()
	update_content()

func _on_DialoguePlayer_finished():
	emit_signal("dialogue_ended")
	hide()

func update_content() -> void:
	var dialogue_player_name = dialogue_player.title
	if dialogue_player_name:
		name_label.show()
		portrait.show()
		name_label.text = dialogue_player_name
		name_label.get_minimum_size()
		portrait.texture = DialogueDatabase.get_texture(dialogue_player_name, dialogue_player.expression)
	else:
		name_label.hide()
		portrait.hide()
	text_label.text = dialogue_player.text
	text_label.visible_characters = 0
	timer.start()

func _on_Timer_timeout():
	text_label.visible_characters += 1
	if text_label.visible_characters >= text_label.text.length():
		timer.stop()
