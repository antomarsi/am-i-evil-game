extends Node2D

onready var bars_node = $BarsNode

var bar_scene = preload("res://prefabs/Bar.tscn")
var bars = []
var bar_lenght_in_m = 200
var current_location = Vector2(0, -200)
var speed = 80
func _ready():
	for i in range(4):
		add_bar()
		
func _process(delta):
	bars_node.position.y += speed*delta

func add_bar():
	var bar = bar_scene.instance()
	bar.connect("bar_exited", self, "on_bar_removed")
	bar.position = Vector2(current_location.x, current_location.y)
	bars.append(bar)
	bars_node.add_child(bar)
	current_location += Vector2(0, -bar_lenght_in_m)
	
func remove_bar(bar):
	bar.queue_free()
	bars.erase(bar)

func on_bar_removed(bar):
	add_bar()
	self.remove_bar(bar)
