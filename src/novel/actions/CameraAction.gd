extends NovelAction

onready var timer : Timer = $Timer

export var amplitude : = 6.0
export var duration : = 0.8 setget set_duration
export(float, EASE) var DAMP_EASING : = 1.0
export var shake : = false setget set_shake

var enabled : = false


func _ready() -> void:
	randomize()
	set_process(false)
	self.duration = duration


func _process(delta: float) -> void:
	var damping : = ease(timer.time_left / timer.wait_time, DAMP_EASING)
	chapter.camera.offset = Vector2(
		rand_range(amplitude, -amplitude) * damping,
		rand_range(amplitude, -amplitude) * damping)


func _on_ShakeTimer_timeout() -> void:
	self.shake = false


func interact() -> void:
	if not enabled:
		return
	self.shake = true


func set_duration(value: float) -> void:
	duration = value
	timer.wait_time = duration

func set_shake(value: bool) -> void:
	shake = value
	set_process(shake)
	chapter.camera.offset = Vector2()
	if shake:
		timer.start()
