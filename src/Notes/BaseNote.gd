extends Area2D

export(int, 1, 5) var line

var pos
var pos_mod = 40
var length
var length_scale
var is_colliding = false
var is_collected = false
var picker = null
var speed

func _ready():
	_on_ready()

func _on_ready():
	set_pos(self.pos)
	add_listeners()

func _process(delta):
	_on_process(delta)
	
func _on_process(delta):
	pass

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
	self.position = Vector2(x*pos_mod, -(pos/length_scale))

func collect():
	is_collected = true
	picker.is_collecting = false
	hide()

func add_listeners():
	add_to_group("note")
	connect("area_entered", self, "_on_Note_area_entered")
	connect("area_exited", self, "_on_Note_area_exited")

func _on_Note_area_entered(area):
	if area.is_in_group("picker"):
		is_colliding = true
		picker = area


func _on_Note_area_exited(area):
	if area.is_in_group("picker"):
		is_colliding = false
