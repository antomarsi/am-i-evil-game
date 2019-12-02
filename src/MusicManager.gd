extends Node

class_name GameMusicManager

signal params_setted


export (String, FILE) var map_file = null
export(AudioStreamOGGVorbis) var MUSIC
export(float) var DELAY = 1

onready var score_meter : = $ScoreMeter as ScoreMeter
onready var music_node = $MusicNode
onready var road_node = $RoadPivot/Road
onready var camera = $Camera2D
onready var camera_shaker = $Actions/CameraAction

var life_loss = 5
var life_gain = 0.5

var tempo
var bar_length_in_m
var quarter_time_in_sec
var speed
var note_scale
var start_pos_in_sec
var map
var music

func _ready():
	map = load_map()
	var music_path = map.audio.download_link
	music = load(music_path)
	set_params()
	music_node.set_physics_process(true)
	road_node.set_physics_process(true)
	camera_shaker.initialize(self)
	camera_shaker.set_duration(0.3)
	camera_shaker.enabled = true
	
func set_params():
	tempo = int(map.tempo)
	bar_length_in_m = 200
	quarter_time_in_sec = 60/(float(tempo))
	speed = bar_length_in_m/float(4*quarter_time_in_sec)
	note_scale = bar_length_in_m/25
	start_pos_in_sec = (map.start_pos/25*quarter_time_in_sec) + DELAY
	emit_signal("params_setted", self)
	
func load_map():
	var file = File.new()
	file.open(map_file, File.READ)
	var content = file.get_as_text()
	file.close()
	return JSON.parse(content).get_result()


func _on_Road_note_hitted():
	score_meter.add_value(life_gain)

func _on_Road_note_missed(note):
	score_meter.add_value(-life_loss)
	camera_shaker.interact()
