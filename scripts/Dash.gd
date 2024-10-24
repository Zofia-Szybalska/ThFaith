extends State

@export var dash_duration : float = .3
var elapsed_dash := 0.0
var dash_direction = 1

func enter(msg := {}) -> void:
	owner.is_dashing = true
	owner.velocity.y = 0
	if (msg.has("air_dash")):
		owner.can_dash = false
	elapsed_dash = 0
	if owner.sword_direction == 1:
		dash_direction = 1
	else:
		dash_direction = -1

func exit(_msg := {}) -> void:
	owner.is_dashing = false

func physics_update(delta: float) -> void:
	if not state_machine.can_be_controled:
		return
	owner.velocity.x = owner.dash_speed * dash_direction
	elapsed_dash += delta
	if elapsed_dash >= dash_duration:
		if owner.is_on_wall_only():
			state_machine.transition_to("Wall")
		if owner.is_on_floor():
			owner.can_dash = true
			if is_equal_approx(owner.velocity.x, 0.0):
				state_machine.transition_to("Idle")
			else:
				state_machine.transition_to("Run")
		else:
			state_machine.transition_to("Fall")
