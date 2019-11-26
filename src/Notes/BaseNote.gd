extends Area2D

class_name BaseNote

signal note_collected
signal note_missed

var length
var is_in_area

func _ready():
	add_listeners()

func set_pos(line:int, pos_y:int, pos_mod:float, length_scale:float):
	var x : float
	match line:
		1:
			x = -2.5
		2:
			x = -1.5
		3:
			x = -0.5
		4:
			x = 0.5
		5:
			x = 1.5
		6:
			x = 2.5
	self.position = Vector2(x*pos_mod, -(pos_y/length_scale))

func collect():
	emit_signal("note_collected")
	hide()

func add_listeners():
	connect("area_entered", self, "_on_Note_area_entered")
	connect("area_exited", self, "_on_Note_area_exited")

func _on_Picker_pressed(picker):
	if is_in_area:
		collect()

func _on_Picker_stopped(picker):
	pass

func _on_Note_area_entered(area):
	if area.is_in_group("picker"):
		is_in_area = true

func _on_Note_area_exited(area):
	if area.is_in_group("picker"):
		emit_signal("note_missed", self)
		is_in_area = false
		set_physics_process(false)
