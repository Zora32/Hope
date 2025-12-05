extends CharacterBody2D

@export var speed = 10
@export var limit = 0.5
@export var endPoint: Marker2D
@export var startPoint: Marker2D
@onready var animated_sp2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var death_efects: Sprite2D = $deathEfects

@onready var healthbar: ProgressBar = $HealthbarBoss



@onready var animation = $AnimationPlayer

var is_slime_chase: bool = true

var health = 80
var health_max = 80
var health_min = 0

var dead: bool = false
var taking_damage: bool = false
var damage_to_deal = 20
var is_dealing_damage: bool = false

var dir: Vector2
var knockback_force = -20
var is_roaming: bool = true

var player: CharacterBody2D
var player_in_area = false




var startPosition
var endPosition





func _ready() -> void:
	healthbar.init_health(health)
	#startPosition = startPoint.global_position
	#endPosition = endPoint.global_position
	death_efects.visible = false


func changeDirection():
	var tempEnd = endPosition
	endPosition = startPosition
	startPosition = tempEnd


func updateVelociti():pass
	#var moveDirection = (endPosition - position)
	#if moveDirection.length() < limit:
		#changeDirection()
	#velocity = moveDirection.normalized() * speed
	

func updateAnimation():
	if velocity.length() == 0:
		animation.stop()
	else:
		var direction = "Down"
		if velocity.x < 0: direction = "Left"
		elif velocity.x > 0: direction = "Right"
		elif velocity.y < 0: direction = "Up"
		
		animation.play("walk" + direction)

func _physics_process(delta: float) -> void:
	if dead:return
	player = Global.playerBody
	move(delta)
	move_and_slide()
	updateAnimation()

func move(delta):
	if !dead:
		if !is_slime_chase:
			velocity += dir * speed * delta
		elif is_slime_chase and !taking_damage:
			var dir_to_player = position.direction_to(player.position) * speed
			velocity = dir_to_player
		elif taking_damage:
			var knockback_dir = position.direction_to(player.position) * knockback_force
			velocity = knockback_dir
		is_roaming = true
	elif dead:
		velocity.x  = 0

func _on_hurt_box_area_entered(area: Area2D) -> void:
	var damage = 20
	if area == Global.playerDamageZone:
		take_damage(damage)



func _on_direction_timer_timeout() -> void:
	$DirectionTimer.wait_time = choose([1.5,2.0,2.5])
	if !is_slime_chase:
		dir = choose([Vector2.RIGHT, Vector2.LEFT, Vector2.DOWN, Vector2.UP])
		velocity.x = 0

func choose(array):
	array.shuffle()
	return array.front()


func take_damage(damage):
	health -= damage
	#taking_damage = true
	if health <= 0:
		dead_pop()
	
	healthbar.health = health

func dead_pop():
	death_efects.visible = true
	$hitBox.set_deferred("monitorable", false) # отключает урон он взрыва смерти слизня
	dead = true
	animated_sp2d.visible = false
	animation.play("death")
	await animation.animation_finished
	queue_free()
