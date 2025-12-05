extends Sprite2D

#@export var glow_enabled: bool = true
#@export var glow_color: Color = Color(0.4, 1.0, 0.89)
#@export var glow_intensity: float = 2.0
#@export var color_tolerance: float = 0.2
#
#@onready var sprite: Sprite2D = $Sprite2D
#
#func _ready():
	#setup_glow()
	#set_glow_enabled(glow_enabled)
#
#func setup_glow():
	#if sprite:
		#var shader_material = ShaderMaterial.new()
		## Создайте шейдер в редакторе и укажите путь здесь
		#var shader = preload("res://glow_intensity.gdshader")
		#shader_material.shader = shader
		#sprite.material = shader_material
		#update_glow_parameters()
#
#func update_glow_parameters():
	#if sprite and sprite.material:
		#sprite.material.set_shader_parameter("glow_color", glow_color)
		#sprite.material.set_shader_parameter("glow_intensity", glow_intensity)
		#sprite.material.set_shader_parameter("color_tolerance", color_tolerance)
#
#func _process(delta: float) -> void:
	#pass
#
## Включить/выключить подсветку
#func set_glow_enabled(enabled: bool):
	#glow_enabled = enabled
	#if sprite and sprite.material:
		#if enabled:
			#sprite.material.set_shader_parameter("glow_intensity", glow_intensity)
		#else:
			#sprite.material.set_shader_parameter("glow_intensity", 0.0)
#
## Включить подсветку
#func enable_glow():
	#set_glow_enabled(true)
#
## Выключить подсветку
#func disable_glow():
	#set_glow_enabled(false)
#
## Переключить подсветку
#func toggle_glow():
	#set_glow_enabled(!glow_enabled)
#
## Установить цвет подсветки
#func set_glow_color(color: Color):
	#glow_color = color
	#if sprite and sprite.material:
		#sprite.material.set_shader_parameter("glow_color", color)
#
## Установить интенсивность подсветки
#func set_glow_intensity(intensity: float):
	#glow_intensity = intensity
	#if glow_enabled and sprite and sprite.material:
		#sprite.material.set_shader_parameter("glow_intensity", intensity)
#
## Установить допуск цвета
#func set_color_tolerance(tolerance: float):
	#color_tolerance = tolerance
	#if sprite and sprite.material:
		#sprite.material.set_shader_parameter("color_tolerance", tolerance)
