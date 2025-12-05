extends CharacterBody2D

class_name Slime

const speed = 5
var is_slime_chase: bool = false

var health = 80
var health_max = 80
var health_min = 0

var dead: bool = false
var taking_damage: bool = false
var damage_to_deal = 20
var is_dealing_damage: bool = false

var dir: Vector2
var knockback_force = 200
var is_roaming: bool = true


func _process(delta: float) -> void:
	move(delta)
	handle_animation()
	move_and_slide()

func move(delta):
	if !dead:
		if !is_slime_chase:
			velocity += dir * speed * delta
		is_roaming = true
	elif dead:
		velocity.x  = 0

func handle_animation():
	var anim_sprite = $AnimatedSprite2D
	if !dead and !taking_damage and !is_dealing_damage:
		
		if dir.x == -1:
			anim_sprite.play("walkLeft")
		elif dir.x == 1:
			anim_sprite.play("walkRight")
		elif dir.y == -1:
			anim_sprite.play("walkUp")
		elif dir.y == 1:
			anim_sprite.play("walkDown")
	elif !dead and taking_damage and !is_dealing_damage:
		#anim. ранения
		await get_tree().create_timer(0.8).timeout
		taking_damage = false

func _on_direction_timeout() -> void:
	$Direction.wait_time = choose([1.5,2.0,2.5])
	if !is_slime_chase:
		dir = choose([Vector2.RIGHT, Vector2.LEFT, Vector2.DOWN, Vector2.UP])
		velocity.x = 0

func choose(array):
	array.shuffle()
	return array.front()
