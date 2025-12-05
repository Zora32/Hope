extends CharacterBody2D

@onready var healthbar: ProgressBar = $CanvasLayer/HealthbarBoss

var health = 80

func _ready() -> void:
	healthbar.init_health(health)
	Global.finishBoss = false



func _on_hit_box_area_entered(area: Area2D) -> void:
	var damage = 20
	if area == Global.playerDamageZone:
		take_damage(damage)

func take_damage(damage):
	health -= damage
	if health <= 0:
		Global.finishBoss = true
		dead_pop()
	
	healthbar.health = health

func dead_pop():
	queue_free()
