extends ColorRect

signal fade_finished

class_name Transition

onready var anim = $AnimationPlayer

func fade_in() -> void:
	anim.play("transition_in")
	
func fade_out() -> void:
	anim.play("transition_out")

func _on_AnimationPlayer_animation_finished(anim_name):
	var fade
	if anim_name == "transition_in":
		fade = "in"
	else:
		fade = "out"
	emit_signal("fade_finished", fade)
