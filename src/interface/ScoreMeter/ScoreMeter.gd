extends Control

class_name ScoreMeter

enum SCORE_TYPE {ROCKING, DANGER, NORMAL}

signal bar_rocking
signal bar_normal
signal bar_danger
signal game_ended

onready var progress_bar = $Progress
onready var tween = $Tween

export(float) var value = 50 setget set_value
export(float) var rocking_threshold = 90
export(float) var danger_threshold = 20
export(float) var tween_value = 2

var tween_up = true
var type = SCORE_TYPE.NORMAL

func _ready():
	progress_bar.value
	progress_bar_animation()
	

func progress_bar_animation():
	if tween_up:
		tween.interpolate_property(progress_bar, "value", progress_bar.value, value+tween_value, 1, Tween.TRANS_QUAD, Tween.EASE_OUT)
	else:
		tween.interpolate_property(progress_bar, "value", progress_bar.value, value-tween_value, 1, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween_up = not tween_up
	tween.start()
	
func add_value(_value):
	set_value(value + _value)

func set_value(_value: float):
	value = _value
	if value <= 0:
		emit_signal("game_ended")
	elif value <= danger_threshold and not type == SCORE_TYPE.DANGER:
		type = SCORE_TYPE.DANGER
		emit_signal("bar_danger")
	elif value >= rocking_threshold and not type == SCORE_TYPE.ROCKING:
		type = SCORE_TYPE.ROCKING
		emit_signal("bar_rocking")
	elif value < rocking_threshold and type == SCORE_TYPE.ROCKING:
		type = SCORE_TYPE.NORMAL
		emit_signal("bar_normal")
	elif value > danger_threshold and type == SCORE_TYPE.DANGER:
		type = SCORE_TYPE.NORMAL
		emit_signal("bar_normal")
	tween.stop_all()
	tween.interpolate_property(progress_bar, "value", progress_bar.value, value, 1, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.start()

func _on_Tween_tween_completed(object, key):
	progress_bar_animation()
