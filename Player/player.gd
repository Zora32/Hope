extends CharacterBody2D

class_name Player

signal hearthChanged



@export var maxHealth = 3 * 4
@export var knockbackPower: int = 500

var isHurt: bool = false
var enemyCollisions = []
var lastAnimaDirection: String = "Down"
var isAttacking: bool = false

@export var speed: int = 35
@onready var animPlayer: AnimationPlayer = $AnimationPlayer
@onready var effects: AnimationPlayer = $Effects
@onready var hurt_timer: Timer = $hurtTimer
@onready var hurt_box: Area2D = $hurtBox
@onready var weapon: Node2D = $weapon
@onready var sprite_2d: Sprite2D = $Sprite2D

@onready var currentHealth: int = maxHealth

@export var inventory: Inventory

func _ready() -> void:
	inventory.use_item.connect(use_item)
	effects.play("RESET")
	weapon.disable()



func handleInpyt():
	var moveDirection = Input.get_vector("ui_left", "ui_right","ui_up","ui_down")
	velocity = moveDirection * speed
	
	if Input.is_action_just_pressed("Attack"):
		attack()

func attack():
	#sprite_2d.material.set_shader_parameter("in_color", mix_color)  передаеться цвет в шейдар
	animPlayer.play("attack" + lastAnimaDirection)
	isAttacking = true
	weapon.enable()
	await animPlayer.animation_finished
	weapon.disable()
	isAttacking = false

func updateAnimation():
	if isAttacking: return
	
	if velocity.length() == 0:
		animPlayer.stop()
	else:
		var direction = "Down"
		if velocity.x < 0: direction = "Left"
		elif velocity.x > 0: direction = "Right"
		elif velocity.y < 0: direction = "Up"
		
		animPlayer.play("walk" + direction)
		lastAnimaDirection = direction

func hangleCollision():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		print_debug(collider.name)


func _physics_process(_delta: float) -> void:
	handleInpyt()
	updateAnimation()
	move_and_slide()
	hangleCollision()
	if !isHurt:
		for area in hurt_box.get_overlapping_areas():
			if area.name == "hitBox":
				hurtByEnemy(area)

func get_global_center_position() -> Vector2:
	return global_position + sprite_2d.position

func clamp_to_limits(limit_position: Vector2, limit_size: Vector2):
	global_position.x = clamp(global_position.x, limit_position.x +8, limit_position.x + limit_size.x -8)
	global_position.y = clamp(global_position.y, limit_position.y +16, limit_position.y + limit_size.y)

func hurtByEnemy(area):
	currentHealth -= 1
	if currentHealth < 0:
		currentHealth = maxHealth
		
	hearthChanged.emit(currentHealth)
	isHurt = true
	
	knockback(area.get_parent().velocity)
	effects.play("hurtBlink")
	hurt_timer.start()
	await hurt_timer.timeout
	effects.play("RESET")
	isHurt = false

func _on_hurt_box_area_entered(area: Area2D) -> void:
	if area.has_method("collect"): #проверяет облать обьекта есть ли у этого обекта метод Collect если да то выполняеться действие
		area.collect(inventory)



func knockback(enemyVelocity: Vector2):
	var knockbackDirection = (enemyVelocity - velocity).normalized() * knockbackPower
	velocity = knockbackDirection
	move_and_slide()


func increase_health(amount: int):
	currentHealth += amount
	currentHealth = min(maxHealth, currentHealth)
	
	hearthChanged.emit(currentHealth)

func use_item(item: InventoryItem):
	if not item.can_be_used(self): return
	item.use(self)
	if item.consumable:
		inventory.remowe_last_used_item()
