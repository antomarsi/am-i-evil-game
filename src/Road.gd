extends Node2D

signal bar_ended

onready var bars_node = $BarsNode

var bar_scene = preload("res://prefabs/Bar.tscn")
var bars = []
var bar_length_in_m = 200
var current_location = Vector2(0, -200)
var speed = 80
var note_scale
var current_bar_index = 0
var tracks_data
var pos_mod = 32

onready var keys = [
	$Keys/Key1,
	$Keys/Key2,
	$Keys/Key3,
	$Keys/Key4,
	$Keys/Key5
]

func _ready():
	set_physics_process(false)

func _process(delta):
	bars_node.position.y += speed*delta

func add_bars():
	for i in range(4):
		add_bar()

func add_bar():
	var bar_data = get_bar_data(current_bar_index)
	if bar_data == null:
		emit_signal("bar_ended")
		return
	var bar = bar_scene.instance()
	bar.connect("bar_exited", self, "on_bar_removed")
	bar.position = Vector2(current_location.x, current_location.y)
	bar.note_scale = note_scale
	bar.speed = speed
	bar.pos_mod = pos_mod
	bar.set_bar_size(pos_mod*2.5, bar_length_in_m)
	bar.add_notes(bar_data, keys)
	bars.append(bar)
	bars_node.add_child(bar)
	current_location += Vector2(0, -bar_length_in_m)
	current_bar_index += 1
	
func get_bar_data(index):
	if not tracks_data[0].bars[index]:
		return null
	var key_1 = tracks_data[0].bars[index]
	var key_2 = tracks_data[1].bars[index]
	return [key_1, key_2]
	
func remove_bar(bar):
	bar.queue_free()
	bars.erase(bar)

func on_bar_removed(bar):
	add_bar()
	self.remove_bar(bar)


func _on_GameManager_params_setted(game:GameMusicManager):
	speed = game.speed
	bar_length_in_m = game.bar_length_in_m
	current_location = Vector2(0, -(bar_length_in_m + (game.start_pos_in_sec*speed)))
	note_scale = game.note_scale
	tracks_data = game.map.tracks
	add_bars()
