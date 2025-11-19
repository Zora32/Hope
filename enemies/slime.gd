extends CharacterBody2D

@export var speed = 20
@export var limit = 0.5
@export var endPoint: Marker2D
@export var startPoint: Marker2D
@onready var animated_sp2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var death_efects: Sprite2D = $deathEfects


@onready var animation = $AnimationPlayer

var isDead: bool = false

var startPosition
var endPosition


func _ready() -> void:
	startPosition = startPoint.global_position
	endPosition = endPoint.global_position
	death_efects.visible = false


func changeDirection():
	var tempEnd = endPosition
	endPosition = startPosition
	startPosition = tempEnd


func updateVelociti():
	var moveDirection = (endPosition - position)
	if moveDirection.length() < limit:
		changeDirection()
	velocity = moveDirection.normalized() * speed
	

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
	if isDead:return
	updateVelociti()
	move_and_slide()
	updateAnimation()


func _on_hurt_box_area_entered(area: Area2D) -> void:
	if area == $hitBox: return
	death_efects.visible = true
	$hitBox.set_deferred("monitorable", false) # отключает урон он взрыва смерти слизня
	isDead = true
	animated_sp2d.visible = false
	animation.play("death")
	await animation.animation_finished
	queue_free()
