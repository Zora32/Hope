extends DirectionalLight2D


@export var day_color: Color
@export var zakat_color: Color
@export var night_color: Color
@export var racwet_color: Color

@export var day_start: DateTime
@export var zakat_start: DateTime
@export var night_start:DateTime
@export var racwet_start: DateTime

@export var transition_time: int = 30 # минуты
@export var time_system: TimeSystem

var in_transition: bool = false

enum DayState {DAY, ZAKAT, NIGHT, RACWET, }
var current_state: DayState = DayState.DAY

@onready var time_map: Dictionary = {
	DayState.DAY: day_start,
	DayState.ZAKAT: zakat_start,
	DayState.NIGHT: night_start,
	DayState.RACWET: racwet_start,
}

@onready var transition_map: Dictionary = {
	DayState.DAY: DayState.ZAKAT,
	DayState.ZAKAT: DayState.NIGHT,
	DayState.NIGHT: DayState.RACWET,
	DayState.RACWET: DayState.DAY,
}

@onready var color_map: Dictionary = {
	DayState.DAY: day_color,
	DayState.ZAKAT: zakat_color,
	DayState.NIGHT: night_color,
	DayState.RACWET: racwet_color,
}

func _ready() -> void:
	pass
	#var diff_day_start = time_system.date_time.diff_without_days(day_start)
	#var diff_night_start = time_system.date_time.diff_without_days(night_start)
	#if diff_day_start < 0 or diff_night_start > 0:
		#current_state = DayState.NIGHT


func update(game_time: DateTime):
	var next_state = transition_map[current_state]
	var change_time = time_map[next_state]
	var time_diff = change_time.diff_without_days(game_time)
	
	if in_transition:
		update_transition(time_diff, next_state)
	elif time_diff > 0 && time_diff < (transition_time * 60):
		in_transition = true
		update_transition(time_diff, next_state)
	else:
		color = color_map[current_state]
		# обновление перехода
	if current_state == 2:
		Global.state = true
	else:
		Global.state = false

func update_transition(time_diff: int, next_state: DayState):
	var ratio = 1 - (time_diff as float / (transition_time * 60))
	if ratio > 1:
		current_state = next_state
		
		in_transition = false
	else:
		color = color_map[current_state].lerp(color_map[next_state], ratio)
