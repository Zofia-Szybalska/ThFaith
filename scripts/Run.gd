extends State


func enter(_msg := {}) -> void:
	owner.can_double_jump = true
	owner.can_dash = true
	owner.animation_player.play("idle")

func physics_update(delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		state_machine.transition_to("Attack")
	if not owner.is_on_floor():
		if owner.is_on_wall_only():
			state_machine.transition_to("Wall")
		else:
			state_machine.transition_to("Fall", {coyote = true})
		return
	owner.velocity.x = PlayerVariables.player_speed * owner.direction
	owner.velocity.y += owner.gravity * delta
	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Jump")
	if Input.is_action_just_pressed("dash"):
		state_machine.transition_to("Dash")
	elif is_equal_approx(owner.direction, 0.0):
		state_machine.transition_to("Idle")
