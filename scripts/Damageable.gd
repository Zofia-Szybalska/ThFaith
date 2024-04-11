extends Node

class_name Damageable

@export var health = 30

func hit(damage: int):
	health -= damage
	print("Oberwał za " + str(damage))
	if health <= 0:
		get_parent().queue_free()


