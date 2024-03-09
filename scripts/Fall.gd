extends State


func physics_update(delta: float) -> void:
	if owner.is_on_floor():
		if is_equal_approx(owner.velocity.x, 0.0):
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Run")
		return
	var direction = Input.get_axis("left","right")
	owner.velocity.x = owner.speed * direction
	owner.velocity.y += owner.gravity * delta
