extends Node

onready var player = $Music
onready var delay_timer = $Delay

var speed
var pre_start_duration
var start_pos_in_sec
var started = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func setup(game:GameMusicManager):
	player.stream = game.music
	speed = game.speed
	started = false
	pre_start_duration = game.bar_lenght_in_m
	delay_timer.wait_time = (pre_start_duration/speed) + game.start_pos_in_sec
	delay_timer.start()

func start():
	started = true
	player.play()

func _on_Delay_timeout():
	start()
