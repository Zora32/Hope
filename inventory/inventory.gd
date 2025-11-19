extends Resource

class_name Inventory
signal updated
signal use_item

@export var slots: Array[InventorySlot]
var index_of_last_use_item: int = -1

func insert(item: InventoryItem):
	for slot in slots:
		if slot.item == item && slot.amout < item.max_amount:
			slot.amout += 1
			updated.emit()
			return
	
	for i in range(slots.size()):
		if !slots[i].item:
			slots[i].item = item
			slots[i].amout = 1
			updated.emit()
			return

func removeSlot(inventorySlot: InventorySlot):
	var index = slots.find(inventorySlot)
	if index < 0: return
	
	remove_at_index(index)

func remove_at_index(index: int):
	slots[index] = InventorySlot.new()
	updated.emit()

func insertSlot(index: int, inventorySlot: InventorySlot):
	
	slots[index] = inventorySlot
	updated.emit()

func use_item_at_index(index: int):
	if index < 0 or index >=slots.size() or !slots[index].item: return
	
	var slot = slots[index]
	index_of_last_use_item = index
	use_item.emit(slot.item)

func remowe_last_used_item():
	if index_of_last_use_item < 0: return
	var slot = slots[index_of_last_use_item]
	if slot.amout > 1:
		print_debug(slot.amout)
		slot.amout -= 1
		updated.emit()
		
		return
	
	remove_at_index(index_of_last_use_item)
	
		  
