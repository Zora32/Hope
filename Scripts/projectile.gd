extends Area2D

var speed: float = 100.0
var target_position: Vector2  # Фиксированная позиция вместо живого объекта
var damage = 5
var direction: Vector2  # Направление вычисляется один раз
var has_moved = false

func _ready() -> void:
	add_to_group("projectiles")
	# Вычисляем направление один раз при создании
	direction = (target_position - global_position).normalized()
	# Поворачиваем пулю в направлении движения (опционально)
	look_at(target_position)

func _process(delta: float) -> void:
	# Двигаемся в фиксированном направлении
	position += direction * speed * delta
	has_moved = true
	
	# Уничтожаем если пуля пролетела достаточно далеко
	# или вышла за пределы экрана
	if has_moved and global_position.distance_to(target_position) < 10:
		queue_free()

func get_damage() -> int:
	return damage


func _on_body_entered(body: Node2D) -> void:
	# Проверяем, что это игрок (или другой нужный объект)
	if body is Player:
		queue_free()
