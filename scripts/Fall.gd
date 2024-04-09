extends State

@export var double_jump_unlocked: bool = false
@export var coyote_time: float = .15
@export var wall_coyote_time: float = .1
var coyote_elapsed: float = 0
var coyote: bool = false
var wall_coyote: bool = false

func enter(msg := {}) -> void:
	coyote_elapsed = 0
	coyote = false
	if msg.has("coyote"):
		coyote = true
	if msg.has("wall_coyote"):
		wall_coyote = true
	owner.animation_player.play("fall")

func physics_update(delta: float) -> void:
	coyote_elapsed += delta
	if owner.is_on_floor():
		if is_equal_approx(owner.velocity.x, 0.0):
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Run")
		return
	if owner.is_on_wall_only():
		state_machine.transition_to("Wall")
	if Input.is_action_just_pressed("jump"):
		if (coyote and coyote_elapsed < coyote_time) or (wall_coyote and coyote_elapsed < wall_coyote_time):
			state_machine.transition_to("Jump")
		elif owner.can_double_jump and double_jump_unlocked:
			owner.can_double_jump = false
			state_machine.transition_to("Jump", {second_jump = true})
		return
	if Input.is_action_just_pressed("dash") and owner.can_dash:
		state_machine.transition_to("Dash", {air_dash = true})
	owner.velocity.x = owner.speed * owner.direction
	owner.velocity.y += owner.gravity * delta
