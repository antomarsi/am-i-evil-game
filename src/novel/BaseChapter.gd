extends Node

class_name BaseChapter

export(PackedScene) var next_scene

onready var dialogue_box = $DialogueBox
onready var camera = $Camera2D
onready var audio = $AudioStreamPlayer

func _ready():
	assert(dialogue_box)
	for action in get_tree().get_nodes_in_group("novel_action"):
		(action as NovelAction).initialize(self)
	audio.playing = true
	$Transition.fade_in()
	yield($Transition, "fade_finished")
	$Actions/DialogueAction.interact()

func play_dialogue(data):
	dialogue_box.start(data)
	yield(dialogue_box, "dialogue_ended")

func play_shake(duration, amplitude = 6):
	var shaker = $Actions/CameraAction
	shaker.set_duration(duration)
	shaker.amplitude = amplitude
	shaker.interact()

func _on_Timer_timeout():
	pass

func _on_DialogueAction_finished():
	$Transition.fade_out()
	yield($Transition, "fade_finished")
	get_tree().change_scene
