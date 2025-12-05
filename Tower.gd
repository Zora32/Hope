extends Area2D



@export var projectile: PackedScene
@onready var shoot_point: Marker2D = $"../Marker2D"

var attackSpeed: float = 2.0
var atackDamage = 5
var playerArr: Array[Player] = []

func _ready() -> void:

	
	$"../TimerAttack".wait_time = attackSpeed
	$"../TimerAttack".autostart = true
	$"../TimerAttack".start()

func _on_body_entered(body: Node2D) -> void:
	if body is Player and !playerArr.has(body):
		playerArr.append(body)
		print(playerArr.size())

func _on_body_exited(body: Node2D) -> void:
	if body is Player and playerArr.has(body):
		playerArr.erase(body)

func _on_timer_attack_timeout() -> void:
	var target = get_target()
	if target:
		shoot(target)

func get_target():
	if !playerArr.is_empty():
		return playerArr[0]
	return null

func shoot(target):
	var new_projectile = projectile.instantiate()
	new_projectile.position = shoot_point.position
	new_projectile.damage = atackDamage
	new_projectile.target_position = target.global_position
	
	
	get_parent().add_child(new_projectile)
