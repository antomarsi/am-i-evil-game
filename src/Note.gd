extends Area2D

export(int, 1, 5) var line

var pos
var pos_mod = 40
var is_colliding = false
var is_collected = false
var picker = null

func _ready():
	set_pos(self.pos)

func _process(delta):
	collect()

func set_pos(pos):
	var x
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
	self.position = Vector2(x*pos_mod, pos)

func collect():
	if not is_collected:
		if is_colliding and picker and picker.is_collecting:
			is_collected = true
			picker.is_collecting = false
			hide()


func _on_Note_area_entered(area):
	if area.is_in_group("picker"):
		is_colliding = true
		picker = area


func _on_Note_area_exited(area):
	if area.is_in_group("picker"):
		is_colliding = false
