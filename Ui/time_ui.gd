extends Control

@onready var days_label: Label = $DayControl/days
@onready var house_lable: Label = $ClokControl/house
@onready var minutes_lable: Label = $ClokControl/minutes


func _on_time_system_updated(date_time: DateTime) -> void:
	update_lable(days_label, date_time.days, false)
	update_lable(house_lable, date_time.hours)
	update_lable(minutes_lable, date_time.minutes)

func add_leading_zero(label: Label, value: int):
	if value < 10:
		label.text += '0'
		
func update_lable(label: Label, value: int, should_have_zero: bool = true):
	label.text = ""
	
	if should_have_zero:
		add_leading_zero(label,value)
		
	label.text += str(value)
