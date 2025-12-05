extends Area2D

@onready var shape : CollisionShape2D = $CollisionShape2D
@onready var deal_damage_zone = $"."

func _ready() -> void:
	Global.playerDamageZone = deal_damage_zone

func enable():
	shape.disabled = false

func disable():
	shape.disabled = true
