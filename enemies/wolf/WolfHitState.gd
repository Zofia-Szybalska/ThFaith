extends HitState


func _on_timer_timeout():
	damagable.can_be_damaged = true
	damagable.get_parent().modulate = Color.WHITE
	if owner.player_detecting_ray_cast.is_colliding():
		owner.player = owner.player_detecting_ray_cast.get_collider()
		state_machine.transition_to("Attack")
		owner.velocity.x = 0
		return
	else:
		state_machine.transition_to("Walk")

