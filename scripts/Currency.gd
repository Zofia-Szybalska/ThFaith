extends RigidBody2D

@export var amount: int = 5


func _on_body_entered(body):
	print("Gracz w obszarze")
	if body is Player:
		PlayerVariables.currency += amount
		queue_free()


func _on_area_2d_body_entered(body):
	if body is Player:
		PlayerVariables.currency += amount
		queue_free()
