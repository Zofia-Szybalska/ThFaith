extends State


func physics_update(delta: float) -> void:
	if not owner.is_on_floor():
		state_machine.transition_to("Fall")
		return

	# We move the run-specific input code to the state.
	# A good alternative would be to define a `get_input_direction()` function on the `Player.gd`
	# script to avoid duplicating these lines in every script.
	var direction = Input.get_axis("left","right")
	owner.velocity.x = owner.speed * direction
	owner.velocity.y += owner.gravity * delta
	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Jump")
	elif is_equal_approx(direction, 0.0):
		state_machine.transition_to("Idle")
