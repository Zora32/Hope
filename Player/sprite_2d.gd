extends Sprite2D

@export var mix_color: Color = Color.BLUE_VIOLET

var shader_material: ShaderMaterial
var time_sum: float = 1.0

func _ready() -> void:
	var shader_material = material as ShaderMaterial
	if shader_material:
		shader_material.set_shader_parameter("in_color", mix_color)
	

	
