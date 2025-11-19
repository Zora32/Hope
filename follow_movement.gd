class_name FollowMovementC extends Node

@export var speed = 10
@onready var parent: CharacterBody2D = get_parent()
@export var follow_distance: int = 50
@export var overshoot_limit: int = 2
@onready var follow_area = $"../Foliow"


var start_position
var target: Player

enum State{IDLE, FOLLOW, BACK}
var current_state: State = State.IDLE

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_position = parent.position

func update_velocity():
	pass
	#
	#if !target:
		#var dir_to_start = start_position - parent.global_position
		#if dir_to_start.length() < overshoot_limit:
			#parent.global_position = start_position
			#return
		#parent.velocity = dir_to_start.normalized() * speed
		#return
	#
	#var dist_to_start = (start_position - parent.global_position).length()
	#if dist_to_start > follow_distance:
		#target = null
		#return
	#
	#var direction = target.global_position - parent.global_position
	#var new_velocity = direction.normalized() * speed
	#parent.velocity = new_velocity

func idle_state():
	parent.velocity = Vector2.ZERO
	var overlapping = follow_area.get_overlapping_bodies()
	var filtered = overlapping.filter(func(b): return b is Player)
	if !filtered.is_empty():
		target = filtered[0]
		current_state = State.FOLLOW

func follow_state():
	var dist_to_start = (start_position - parent.global_position).length()
	if dist_to_start > follow_distance:
		target = null
		current_state = State.BACK
		return
	
	var direction = target.global_position - parent.global_position
	var new_velocity = direction.normalized() * speed
	parent.velocity = new_velocity

func back_state():
	var dir_to_start = start_position - parent.global_position
	if dir_to_start.length() < overshoot_limit:
		parent.global_position = start_position
		current_state = State.IDLE
		return
	parent.velocity = dir_to_start.normalized() * speed
	return


func _physics_process(delta: float) -> void:
	match current_state:
		State.IDLE:
			idle_state()
		State.FOLLOW:
			follow_state()
		State.BACK:
			back_state()
	
	update_velocity()
	parent.move_and_slide()


#func _on_foliow_body_entered(body: Node2D) -> void:
	#if body is Player && current_state == State.IDLE:
		#target = body
		#current_state = State.FOLLOW
