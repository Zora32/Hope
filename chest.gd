extends StaticBody2D


@export var item: Array[InventoryItem]
var coint_preload = preload("res://Collectobls/lifepot.tscn")
@onready var animations: AnimationPlayer = $AnimationPlayer
@onready var item_start_pos: Vector2 = $ItemStartPos.position
@onready var item_end_pos: Vector2 = $itemEndPos.position


var is_open: bool = false

func interact(interacter: Node2D):
	if is_open: return


	is_open = true
	animations.play("open")
	await animations.animation_finished
	spawn_and_collect(interacter)

func spawn_and_collect(interacter: Node2D):
	
	for i: InventoryItem in item:
		for a in range(1):
			var sprite := Sprite2D.new()
			sprite.texture = i.texture
			sprite.position = item_start_pos
			add_child(sprite)
			
			var tween = create_tween()
			tween.tween_property(sprite, "position", item_end_pos, 0.3)
			await tween.finished
			
			var tween_collect = create_tween()
			tween_collect.tween_property(sprite, "global_position", interacter.global_position, 0.4)
			tween_collect.tween_callback(func():
				sprite.queue_free()
				interacter.inventory.insert(i))
   
