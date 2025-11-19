extends Area2D
class_name ScenaTriger

@export var connected_scene: String # название сцены
var scene_folder = "res://Scene/"


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		scene_manager.change_scene(get_owner(), connected_scene)
