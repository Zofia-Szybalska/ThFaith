extends State

func enter(_msg := {}) -> void:
	owner.velocity = Vector2.ZERO
	owner.can_double_jump = true


func update(_delta: float) -> void:
	if not owner.is_on_floor():
		state_machine.transition_to("Fall")
		return

	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Jump")
	elif Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		state_machine.transition_to("Run")
