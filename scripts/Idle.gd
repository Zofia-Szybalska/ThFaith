extends State


func enter(_msg := {}) -> void:
	owner.velocity = Vector2.ZERO
	owner.can_double_jump = true
	owner.can_dash = true
	owner.animation_player.play("idle")

func update(_delta: float) -> void:
	if not owner.is_on_floor():
		if owner.is_on_wall_only():
			state_machine.transition_to("Wall")
		else:
			state_machine.transition_to("Fall", {coyote = true})
		return
	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Jump")
	if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		state_machine.transition_to("Run")
	if Input.is_action_just_pressed("dash"):
		state_machine.transition_to("Dash")
