extends Area2D

@export var damage: int = 10
var right_pos: Vector2 = Vector2(45,0)


func _ready():
	monitoring = false

func _on_body_entered(body):
	for child in body.get_children():
		if child is Damageable:
			child.hit(damage)


func _on_animation_player_animation_finished(anim_name):
	monitoring = false
