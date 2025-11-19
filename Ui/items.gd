extends Panel

class_name ItemStackGui

@onready var item: Sprite2D = $item
@onready var amout_label: Label = $amoutLabel


var inventorySlot: InventorySlot

func update():
	if !inventorySlot or !inventorySlot.item: return
	
	item.visible = true
	item.texture = inventorySlot.item.texture
	amout_label.visible = true
	if inventorySlot.amout == 1:
		amout_label.visible = false
	else:
		amout_label.text = str(inventorySlot.amout)
