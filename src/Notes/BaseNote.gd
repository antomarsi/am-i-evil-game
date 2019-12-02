extends Area2D

class_name BaseNote

signal note_collected
signal note_missed

var is_in_area
var collected = false

func _ready():
	add_listeners()

func set_pos(line:int, pos_y:int, pos_mod:float, length_scale:float):
	var x : float
	match line:
		1:
			x = -2
		2:
			x = -1
		3:
			x = 0
		4:
			x = 1
		5:
			x = 2
	self.position = Vector2(x*pos_mod, -(pos_y/length_scale))
	$Sprite.frame = line-1

func collect():
	if collected:
		return
	emit_signal("note_collected")
	collected = true
	hide()

func add_listeners():
	connect("area_entered", self, "_on_Note_area_entered")
	connect("area_exited", self, "_on_Note_area_exited")

func _on_Picker_pressed(picker):
	if is_in_area and picker.note == self:
		collect()
		picker.note = null

func _on_Picker_stopped(picker):
	pass

func _on_Note_area_entered(area):
	if area.is_in_group("picker"):
		is_in_area = true

func _on_Note_area_exited(area):
	if area.is_in_group("picker") and not collected:
		emit_signal("note_missed", self)
		is_in_area = false
