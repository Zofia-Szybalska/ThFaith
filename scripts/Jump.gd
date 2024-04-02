extends State

@export var jump_duration : float = .4
var elapsed_jump := 0.0

func enter(msg := {}) -> void:
	jump_duration = .4
	owner.velocity.y = -owner.jump_force
	if (msg.has("second_jump")):
		jump_duration = .25
	if (msg.has("wall_jump")):
		print("wall jump")
		jump_duration = .3
		##TODO pushback
	elapsed_jump = 0

func physics_update(delta: float) -> void:
	elapsed_jump += delta 
	if Input.is_action_just_released("jump") or elapsed_jump >= jump_duration:
		state_machine.transition_to("Fall")
	if Input.is_action_just_pressed("dash") and owner.can_dash:
		state_machine.transition_to("Dash", {air_dash = true})
	if owner.is_on_wall() and owner.ray_cast_2d.is_colliding() and (Input.is_action_pressed("left") or Input.is_action_pressed("right")):
		state_machine.transition_to("Wall")
	owner.velocity.x = owner.speed * owner.direction
	if owner.is_on_floor():
		if is_equal_approx(owner.velocity.x, 0.0):
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Run")
