extends Node2D

onready var bars_node = $BarsNode

var bar_scene = preload("res://prefabs/Bar.tscn")
var bars = []
var bar_lenght_in_m = 200
var current_location = Vector2(0, -200)
var speed = 80
var note_scale
var current_bar_index = 0
var tracks_data

func _process(delta):
	bars_node.position.y += speed*delta

func setup(game:GameMusicManager):
	speed = game.speed
	bar_lenght_in_m = game.bar_lenght_in_m
	current_location = Vector2(0, -(bar_lenght_in_m + (game.start_pos_in_sec*speed)))
	note_scale = game.note_scale
	tracks_data = game.map.tracks
	add_bars()

func add_bars():
	for i in range(4):
		add_bar()

func add_bar():
	var bar = bar_scene.instance()
	bar.bar_data = get_bar_data(current_bar_index)
	bar.connect("bar_exited", self, "on_bar_removed")
	bar.position = Vector2(current_location.x, current_location.y)
	bar.note_scale = note_scale
	bars.append(bar)
	bars_node.add_child(bar)
	current_location += Vector2(0, -bar_lenght_in_m)
	current_bar_index += 1
	
func get_bar_data(index):
	var key_1 = tracks_data[0].bars[index]
	var key_2 = tracks_data[1].bars[index]
	return [key_1, key_2]
	
func remove_bar(bar):
	bar.queue_free()
	bars.erase(bar)

func on_bar_removed(bar):
	add_bar()
	self.remove_bar(bar)
