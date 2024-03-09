extends State


func physics_update(delta: float) -> void:
	if owner.is_on_floor():
		if is_equal_approx(owner.velocity.x, 0.0):
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Run")
		return
	if Input.is_action_just_pressed("jump") and owner.can_double_jump:
		owner.can_double_jump = false
		state_machine.transition_to("Jump", {second_jump = true})
		return
	owner.velocity.x = owner.speed * owner.direction
	owner.velocity.y += owner.gravity * delta
