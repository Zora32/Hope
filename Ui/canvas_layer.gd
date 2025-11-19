extends CanvasLayer

@onready var invertoy: Control = $InvertoyGui

func _ready() -> void:
	invertoy.close()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_inventot"):
		if invertoy.isOpen:
			invertoy.close()
		else:
			invertoy.open()
	
