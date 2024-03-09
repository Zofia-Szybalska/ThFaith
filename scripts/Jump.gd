extends State


func enter(_msg := {}) -> void:
	owner.velocity.y = -owner.jump_force
	$Timer.start()

func exit() -> void:
	$Timer.stop()

func physics_update(_delta: float) -> void:
	if Input.is_action_just_released("jump"):
		state_machine.transition_to("Fall")
	owner.velocity.x = owner.speed * owner.direction
	if owner.is_on_floor():
		if is_equal_approx(owner.velocity.x, 0.0):
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Run")

func _on_timer_timeout():
	if not owner.is_on_floor():
		state_machine.transition_to("Fall")
	else:
		if is_equal_approx(owner.velocity.x, 0.0):
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Run")
