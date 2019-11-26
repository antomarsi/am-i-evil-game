extends Node

onready var player = $Music
onready var delay_timer = $Delay

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(false)

func _on_Delay_timeout():
	player.play()

func _on_GameManager_params_setted(game: GameMusicManager):
	player.stream = game.music	
	delay_timer.wait_time = (game.bar_lenght_in_m/game.speed) + game.start_pos_in_sec
	delay_timer.start()
