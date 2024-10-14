extends HitState

func _on_timer_timeout():
	damagable.can_be_damaged = true
	if damagable.sprites_node:
		damagable.sprites_node.material.set_shader_parameter("hurt", false)
	if owner.player_detecting_ray_cast.is_colliding():
		owner.player = owner.player_detecting_ray_cast.get_collider()
		state_machine.transition_to("Attack")
		owner.velocity.x = 0
		return
	else:
		state_machine.transition_to("Walk")

