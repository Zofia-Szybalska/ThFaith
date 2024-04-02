extends State

var sliding:bool = false
var max_gravity = 250

func enter(_msg := {}) -> void:
	sliding = false

func physics_update(delta: float) -> void:
	if not sliding and (Input.is_action_pressed("left") or Input.is_action_pressed("right")):
		sliding = true
	if Input.is_action_just_pressed("dash") and owner.can_dash:
		state_machine.transition_to("Dash", {air_dash = true})
	if owner.is_on_floor():
		owner.can_dash = true
		if is_equal_approx(owner.velocity.x, 0.0):
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Run")
	if not owner.is_on_wall():
		state_machine.transition_to("Fall")
	if sliding:
		owner.velocity.y = clamp(owner.velocity.y + owner.gravity * 0.5 * delta, 0, max_gravity)
	else:
		owner.velocity.y += owner.gravity * delta
	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Jump", {wall_jump = true})
		return
	owner.velocity.x = owner.speed * owner.direction
