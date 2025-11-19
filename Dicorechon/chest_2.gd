extends StaticBody2D


@onready var animations: AnimationPlayer = $AnimationPlayer


func interact():
	animations.play("open")
