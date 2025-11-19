extends Control

signal opened
signal closed

var isOpen: bool = false
@onready var invectory: Inventory = preload("res://inventory/playerInventory.tres")

@onready var ItemStackGuiClass = preload("res://Ui/itemStackGui.tscn")
@onready var hotbar_slots: Array = $NinePatchRect/HBoxContainer.get_children()
@onready var slots: Array = hotbar_slots + $NinePatchRect/GridContainer.get_children()

var itemInHand: ItemStackGui
var oldIndex: int = -1
var locked: bool = false


func _ready() -> void:
	connectSlots()
	invectory.updated.connect(update)
	update()

func connectSlots():
	for i in range(slots.size()):
		var slot = slots[i]
		slot.index = i 
		
		var callable = Callable(onSlotClicked)
		callable = callable.bind(slot)
		slot.pressed.connect(callable)


func update():
	for i in range(min(invectory.slots.size(), slots.size())):
		var inventorySlot: InventorySlot = invectory.slots[i]
		
		if !inventorySlot.item:
			slots[i].clear()
			continue
		
		var itemStackGui: ItemStackGui = slots[i].itemStackGui
		if !itemStackGui:
			itemStackGui = ItemStackGuiClass.instantiate()
			slots[i].insert(itemStackGui)
			
		itemStackGui.inventorySlot = inventorySlot
		itemStackGui.update()

func open():
	visible = true
	isOpen = true
	opened.emit()

func close():
	visible = false
	isOpen = false
	closed.emit()

func onSlotClicked(slot):
	if locked: return
	
	if slot.isEmpty():
		if !itemInHand: return
		
		insertItemInSlot(slot)
		return
		
	if !itemInHand:
		takeItemFromSlot(slot)
		return
	
	if slot.itemStackGui.inventorySlot.item.name == itemInHand.inventorySlot.item.name:
		stackItems(slot)
		return
	
	swapItems(slot)

func takeItemFromSlot(slot):
	itemInHand = slot.takeItem()
	add_child(itemInHand)
	updateItemInHand() 
	
	oldIndex = slot.index

func insertItemInSlot(slot):
	var item = itemInHand
	remove_child(itemInHand)
	itemInHand = null
	
	slot.insert(item)
	
	oldIndex = -1

func swapItems(slot):
	var tempItem = slot.takeItem()
	
	insertItemInSlot(slot)
	
	itemInHand = tempItem
	add_child(itemInHand)
	updateItemInHand()

func stackItems(slot):
	var slotItem: ItemStackGui = slot.itemStackGui
	var maxAmout = slotItem.inventorySlot.item.max_amount
	var totalAmout = slotItem.inventorySlot.amout + itemInHand.inventorySlot.amout
	
	#if slotItem.inventorySlot.amout == maxAmout:
		#swapItems(slot)
		#return
	if totalAmout <= maxAmout:
		slotItem.inventorySlot.amout = totalAmout
		remove_child(itemInHand)
		itemInHand = null
		oldIndex = -1
	else:
		slotItem.inventorySlot.amout = maxAmout
		itemInHand.inventorySlot.amout = totalAmout - maxAmout
		
	slotItem.update()
	if itemInHand: itemInHand.update()

func updateItemInHand():
	if !itemInHand: return
	itemInHand.global_position = get_global_mouse_position() - itemInHand.size / 2

func putItemBack():
	locked = true
	if oldIndex < 0:
		var emptySlots = slots.filter(func(s): return s.isEmpty())
		if emptySlots.is_empty(): return
		
		oldIndex = emptySlots[0].index
		
	var targetSlot = slots[oldIndex]
	
	var tween = create_tween()
	var targetPosition = targetSlot.global_position + targetSlot.size / 2
	tween.tween_property(itemInHand, "global_position", targetPosition, 1)
	await tween.finished
	insertItemInSlot(targetSlot)
	locked = false

func _input(event: InputEvent) -> void:
	if itemInHand && !locked && Input.is_action_just_pressed("rightClik"):
		putItemBack()
	updateItemInHand()
	
