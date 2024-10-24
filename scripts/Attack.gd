extends State

@onready var attack_timer = $AttackTimer
var curr_state = "idle"

func enter(_msg := {}) -> void:
	owner.is_attacking = true
	attack_timer.start()

func exit(_msg := {}) -> void:
	owner.is_attacking = false
	owner.is_idle = false
	owner.is_running = false
	owner.is_falling = false
	owner.is_dashing = false
	owner.is_jumping = false

func physics_update(delta: float) -> void:
	if not state_machine.can_be_controled:
		return
	owner.velocity.x = PlayerVariables.player_speed * owner.direction  * 0.5
	owner.velocity.y += owner.gravity * delta

func end_attack():
	owner.is_attacking = false
	if not owner.is_on_floor():
		if owner.is_on_wall_only():
			state_machine.transition_to("Wall")
		else:
			state_machine.transition_to("Fall", {coyote = true})
		return
	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Jump")
	if Input.is_action_just_pressed("dash"):
		state_machine.transition_to("Dash")
	if owner.is_on_floor() and not is_equal_approx(owner.direction, 0.0):
		state_machine.transition_to("Run")
	if is_equal_approx(owner.direction, 0.0):
		state_machine.transition_to("Idle")

func _on_timer_timeout():
	end_attack()
