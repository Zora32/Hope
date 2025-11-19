extends BaseScene

@onready var healtsContainer = $CanvasLayer/heartsContainer
@onready var camera = $Camera2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	camera.follow_node = player
	
	healtsContainer.setMaxHearts(player.maxHealth)
	healtsContainer.updateHearts(player.currentHealth)
	player.hearthChanged.connect(healtsContainer.updateHearts)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_invertoy_gui_closed() -> void:
	get_tree().paused = false


func _on_invertoy_gui_opened() -> void:
	get_tree().paused = true
