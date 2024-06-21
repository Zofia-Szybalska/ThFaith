extends State


func enter(msg := {}) -> void:
	owner.can_be_damaged = false
	var direction_sign_vector = msg.get("direction_sign")
	owner.velocity.x = owner.knockack_velocity * direction_sign_vector.x
	owner.velocity.y = owner.knockack_velocity * direction_sign_vector.y * 0.5
	$Timer.start()


func physics_update(delta: float) -> void:
	owner.velocity.x = lerp(owner.velocity.x, float(PlayerVariables.player_speed * owner.direction), 0.25)
	owner.velocity.y += owner.gravity * delta


func _on_timer_timeout():
	owner.can_be_damaged = true
	state_machine.transition_to("Idle")
