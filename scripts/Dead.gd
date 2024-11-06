extends State


func _process_update(delta):
	print("Dead")
	owner.velocity.y += owner.gravity * delta
