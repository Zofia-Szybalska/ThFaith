extends State

@export var jump_duration : float = .4
var elapsed_jump := 0.0
var direction = 1
var wall_jump = false

func enter(msg := {}) -> void:
	direction = owner.direction
	owner.velocity.y = -owner.jump_force
	if (msg.has("second_jump")):
		jump_duration = .25
	elif (msg.has("wall_jump")):
		jump_duration = .3
		owner.velocity.x += owner.wall_jump_pushback * -direction
		wall_jump = true
	if owner.direction == 1:
		owner.animation_player.play("jump_right")
	else:
		owner.animation_player.play("jump_left")

func exit(_msg := {}) -> void:
	jump_duration = .4
	elapsed_jump = 0
	wall_jump = false

func physics_update(delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		state_machine.transition_to("Attack")
	elapsed_jump += delta 
	if Input.is_action_just_released("jump"):
		state_machine.transition_to("Fall")
	if elapsed_jump >= jump_duration:
		state_machine.transition_to("Fall", {jump_ended = true})
	if Input.is_action_just_pressed("dash") and owner.can_dash:
		state_machine.transition_to("Dash", {air_dash = true})
	if owner.is_on_wall_only() and not Input.is_action_pressed("jump") and (Input.is_action_pressed("left") or Input.is_action_pressed("right")):
		state_machine.transition_to("Wall")
	if wall_jump:
		owner.velocity.x = lerp(owner.velocity.x, float(PlayerVariables.player_speed * direction), 0.25)
	elif not is_equal_approx(owner.velocity.x, 0.0):
		owner.velocity.x = PlayerVariables.player_speed * direction
	if owner.direction == 1:
		owner.animation_player.play("jump_right")
	else:
		owner.animation_player.play("jump_left")
	if owner.is_on_floor():
		if is_equal_approx(owner.velocity.x, 0.0):
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Run")
