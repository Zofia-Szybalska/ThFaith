extends State

@export var jump_duration : float = .4
var elapsed_jump := 0.0
var direction = 1
var wall_jump = false

func enter(msg := {}) -> void:
	if owner.sprite.flip_h == true:
		direction = -1
	else:
		direction = 1
	owner.velocity.y = -owner.jump_force
	if (msg.has("second_jump")):
		jump_duration = .25
	elif (msg.has("wall_jump")):
		jump_duration = .3
		owner.velocity.x += owner.wall_jump_pushback * -direction
		wall_jump = true
	owner.animation_player.play("jump")

func exit(_msg := {}) -> void:
	jump_duration = .4
	elapsed_jump = 0

func physics_update(delta: float) -> void:
	elapsed_jump += delta 
	if Input.is_action_just_released("jump") or elapsed_jump >= jump_duration:
		state_machine.transition_to("Fall")
	if Input.is_action_just_pressed("dash") and owner.can_dash:
		state_machine.transition_to("Dash", {air_dash = true})
	if owner.is_on_wall_only() and not Input.is_action_pressed("jump") and (Input.is_action_pressed("left") or Input.is_action_pressed("right")):
		state_machine.transition_to("Wall")
	if wall_jump:
		owner.velocity.x = lerp(owner.velocity.x, float(owner.speed * direction), 0.25)
	else:
		owner.velocity.x = owner.speed * direction
	if owner.is_on_floor():
		if is_equal_approx(owner.velocity.x, 0.0):
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Run")
