extends Area2D

@export var damage: int = 10
var right_pos: Vector2 = Vector2(45,0)
var left_pos: Vector2 = Vector2(-110,0)


func _ready():
	monitoring = false

func _on_body_entered(body):
	for child in body.get_children():
		if child is Damageable:
			var direction_to_damagable = body.global_position - get_parent().global_position
			var direction_sing = sign(direction_to_damagable.x)
			if direction_sing > 0:
				child._on_hit(damage, Vector2.RIGHT)
			elif direction_sing < 0:
				child._on_hit(damage, Vector2.LEFT)
			else:
				child._on_hit(damage, Vector2.ZERO)


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "attack":
		monitoring = false


func _on_area_entered(area):
	for child in area.get_children():
		if child is Damageable:
			print("Ataaak!")
			var direction_to_damagable = area.global_position - get_parent().global_position
			var direction_sing = sign(direction_to_damagable.x)
			if direction_sing > 0:
				child._on_hit(damage, Vector2.RIGHT)
			elif direction_sing < 0:
				child._on_hit(damage, Vector2.LEFT)
			else:
				child._on_hit(damage, Vector2.ZERO)
