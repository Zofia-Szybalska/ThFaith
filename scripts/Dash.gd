extends State

@export var dash_duration : float = .3
var elapsed_dash := 0.0
var dash_direction = 1

func enter(msg := {}) -> void:
	owner.velocity.y = 0
	if owner.direction == 1:
		owner.animation_player.play("dash_right")
	else:
		owner.animation_player.play("dash_left")
	if (msg.has("air_dash")):
		owner.can_dash = false
	elapsed_dash = 0
	if owner.direction == 1:
		dash_direction = 1
	else:
		dash_direction = -1

func physics_update(delta: float) -> void:
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
