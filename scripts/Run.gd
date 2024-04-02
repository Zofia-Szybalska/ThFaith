extends State


func enter(_msg := {}) -> void:
	owner.can_double_jump = true
	owner.can_dash = true

func physics_update(delta: float) -> void:
	if not owner.is_on_floor():
		state_machine.transition_to("Fall", {coyote = true})
		return

	# We move the run-specific input code to the state.
	# A good alternative would be to define a `get_input_direction()` function on the `Player.gd`
	# script to avoid duplicating these lines in every script.
	owner.velocity.x = owner.speed * owner.direction
	owner.velocity.y += owner.gravity * delta
	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Jump")
	if Input.is_action_just_pressed("dash"):
		state_machine.transition_to("Dash")
	elif is_equal_approx(owner.direction, 0.0):
		state_machine.transition_to("Idle")
