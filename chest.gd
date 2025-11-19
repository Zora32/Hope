extends StaticBody2D

@export var items: Array[InventoryItem]
@onready var animations: AnimationPlayer = $AnimationPlayer
@onready var item_start_pos: Vector2 = $ItemStartPos.position
@onready var item_end_pos: Vector2 = $itemEndPos.position


var is_open: bool = false

func interact(interacter: Node2D):
	if is_open: return
	var inventory = interacter.get("inventory")
	if !inventory or inventory is not Inventory: return

	is_open = true
	animations.play("open")
	await animations.animation_finished
	spawn_and_collect(interacter)

func spawn_and_collect(interacter: Node2D):
	pass 
