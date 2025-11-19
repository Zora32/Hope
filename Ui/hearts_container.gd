extends HBoxContainer

@onready var HeartGuiClass = preload("res://Ui/heart_gui.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func setMaxHearts(max: int):
	max = max / 4
	for i in range(max):
		var hearth = HeartGuiClass.instantiate()
		add_child(hearth)

func updateHearts(currentHealth: int):
	var hearts = get_children()
	
	var full_hearts = currentHealth / 4
	
	for i in range(full_hearts):
		hearts[i].update(4)
		
	if full_hearts == hearts.size(): return

	var remainder = currentHealth % 4
	hearts[full_hearts].update(remainder)

	for i in range(full_hearts + 1, hearts.size()):
		hearts[i].update(0)
