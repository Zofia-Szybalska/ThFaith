extends State

@export var double_jump_unlocked: bool = false
@export var coyote_time: float = .15
var coyote_elapsed: float = 0
var coyote: bool = false

func enter(msg := {}) -> void:
	coyote_elapsed = 0
	coyote = false
	if msg.has("coyote"):
		coyote = true
	pass

func physics_update(delta: float) -> void:
	coyote_elapsed += delta
	if owner.is_on_floor():
		if is_equal_approx(owner.velocity.x, 0.0):
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Run")
		return
	if Input.is_action_just_pressed("jump"):
		if coyote and coyote_elapsed < coyote_time:
			state_machine.transition_to("Jump")
		elif owner.can_double_jump and double_jump_unlocked:
			owner.can_double_jump = false
			state_machine.transition_to("Jump", {second_jump = true})
		return
	if Input.is_action_just_pressed("dash") and owner.can_dash:
		state_machine.transition_to("Dash", {air_dash = true})
	owner.velocity.x = owner.speed * owner.direction
	owner.velocity.y += owner.gravity * delta
