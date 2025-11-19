class_name BaseScene extends Node


@onready var player: Player = $Player
@onready var entrance_markers: Node2D = $EntranceMarkers

func _ready() -> void:
	if scene_manager.player:
		if player:
			player.queue_free()
			
		player = scene_manager.player
		add_child(player)
		
	position_player()

func position_player():
	var last_scena = scene_manager.last_scena_name #.to_lower().replace("_", '').replace(' ', '')
	if last_scena.is_empty():
		last_scena = "any"
	
	for entrance in entrance_markers.get_children():
		if entrance is Marker2D and entrance.name == "any" or entrance.name == last_scena:
			player.global_position = entrance.global_position
