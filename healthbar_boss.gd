extends ProgressBar


@onready var timer: Timer = $Timer
@onready var damag_bar: ProgressBar = $ProgressBar

var health = 0: set = _set_health

func _set_health(new_health):
	var prev_health = health
	health = min(max_value, new_health)
	value = health
	
	if health <= 0:
		queue_free()
	
	if health < prev_health:
		timer.start()
	else:
		damag_bar.value = health


func init_health(_health):
	health = _health
	max_value = health
	damag_bar.max_value = health
	damag_bar.value = health
	


func _on_timer_timeout() -> void:
	damag_bar.value = health
