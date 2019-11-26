extends Node2D

class_name GameMusicManager

export (String, FILE) var map_file = null

export(float) var DELAY = 1
onready var music_node = $MusicNode
onready var road_node = $Road

export(AudioStreamOGGVorbis) var MUSIC

var tempo
var bar_lenght_in_m
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
	calc_params()
	music_node.setup(self)
	road_node.setup(self)
	
func calc_params():
	tempo = int(map.tempo)
	bar_lenght_in_m = 200
	quarter_time_in_sec = 60/(float(tempo))
	speed = bar_lenght_in_m/float(4*quarter_time_in_sec)
	note_scale = bar_lenght_in_m/25
	start_pos_in_sec = (map.start_pos/25*quarter_time_in_sec) + DELAY
	
func load_map():
	var file = File.new()
	file.open(map_file, File.READ)
	var content = file.get_as_text()
	file.close()
	return JSON.parse(content).get_result()