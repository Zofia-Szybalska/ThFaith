extends State

@onready var attack_timer = $AttackTimer

func enter(_msg := {}) -> void:
	attack_timer.start()
	if owner.sword_direction == 1:
		owner.animation_player.play("attack_right")
	elif owner.sword_direction == -1:
		owner.animation_player.play("attack_left")

func physics_update(delta: float) -> void:
	if owner.direction == 1:
		owner.animation_player.play("attack_right")
	else:
		owner.animation_player.play("attack_left")
	owner.velocity.x = PlayerVariables.player_speed * owner.direction
	owner.velocity.y += owner.gravity * delta

func end_attack():
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
