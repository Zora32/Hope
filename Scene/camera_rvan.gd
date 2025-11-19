extends Camera2D

@export var player: CharacterBody2D
@onready var size: Vector2i = get_viewport_rect().size
@export var tilemap: TileMap




var current_cell: Vector2i

func _ready() -> void:
	update_position()

func _physics_process(delta: float) -> void:
	var old_cell = current_cell
	update_position()
	if old_cell != current_cell:
		player.clamp_to_limits(global_position, size)



func update_position():
	current_cell = Vector2i(player.get_global_center_position()) / size
	global_position = current_cell * size
